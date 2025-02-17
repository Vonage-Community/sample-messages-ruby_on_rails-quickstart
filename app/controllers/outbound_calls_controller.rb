class OutboundCallsController < ApplicationController
  # Skip CSRF for webhook callbacks from Vonage
  skip_before_action :verify_authenticity_token, only: [:create]

  # Shows the UI for making a call
  def index
    @call = Call.new
  end

  # Make a call
  def create
    # Create a call record to be stored in the database.
    # This is technically not necessary, but it allows us to store the
    # text to be spoken in the database
    @call = Call.new(safe_params)

    if @call.save
      make @call
      redirect_to :outbound_calls, notice: 'Call initiated'
    else
      flash[:alert] = 'Something went wrong'
      render :index
    end
  end

  # Returns the message to play on the phone call
  def show
    # Find the call
    call = Call.find(params[:id])
    # Return a JSON object with the message for the call
    # and also specifying the voice name to use
    render json: [
        {
            "action": "talk",
            "text": call.text,
            "language": "en-AU",
            "style": 3
        }
    ]
  end

  private

  # Initializes the Vonage API client
  def vonage
    # Initialize the Vonage client with API credentials and token
    Vonage::Client.new(
      api_key: ENV["VONAGE_API_KEY"], 
      api_secret: ENV["VONAGE_API_SECRET"], 
      token: generate_vonage_token
    )
  end

  # Generates a JWT token for Vonage API authentication
  def generate_vonage_token
    claims = {
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    }
    Vonage::JWT.generate(claims)
  end

  # Determines the params that can be
  # stored in the database safely
  def safe_params
    params.require(:call).permit(:to, :from, :text)
  end

  # Uses the Vonage API to initiate the call
  def make call
    # Make a call to the number provided,
    # from the Vonage number provided
    options = {
      to: [
        {
          type: 'phone',
          number: call.to
        }
      ],
      from: {
        type: 'phone',
        number: call.from
      },
      # When the call connects, make a webhook
      # to the inbound_calls#show method and play back
      # the voice message specified
      answer_url: [
        # Using ngrok URL to make the endpoint publicly accessible
        "#{ENV['VONAGE_SERVER_HOSTNAME']}/outbound_calls/#{call.id}"
      ]
    }
    response = vonage.voice.create(options)

    # If the call was successfully started,
    # update the status for this call
    call.update(
      uuid: response['uuid'],
      status: response['status']
    ) if response['status'] && response['uuid']
  end
end