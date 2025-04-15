class OutboundCallsController < ApplicationController
  def new
    @call = Call.new
  end

  def create
    @call = Call.new(safe_params)

    if @call.save
      make_call(@call)
      redirect_to new_outbound_call_path, notice: 'Call initiated'
    else
      flash[:alert] = 'Something went wrong'
      render :new
    end
  end

  def show
    call = Call.find(params[:id])
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

  def safe_params
    params.require(:call).permit(:to, :from, :text)
  end

  def vonage
    Vonage::Client.new(
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    )
  end

  def make_call(call)
    options = {
      to: [{ type: 'phone', number: call.to }],
      from: { type: 'phone', number: call.from },
      answer_url: ["https://#{ENV['VONAGE_SERVER_HOSTNAME']}/outbound_calls/#{call.id}"]
    }

    response = vonage.voice.create(options)

    call.update(
      uuid: response['uuid'],
      status: response['status']
    ) if response['status'] && response['uuid']
  end


end
