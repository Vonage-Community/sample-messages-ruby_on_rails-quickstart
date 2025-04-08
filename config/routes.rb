Rails.application.routes.draw do
  get "outbound_calls/new"
  get "outbound_calls/create"
  get "outbound_calls/show"
  # For OutboundSms controller, new & create
  get  '/outbound_sms/new', to: 'outbound_sms#new',    as: :new_outbound_sms
  post '/outbound_sms',     to: 'outbound_sms#create', as: :outbound_sms

  # For SmsMessageStatus controller, create
  post '/sms_message_status', to: 'sms_message_status#create', as: :sms_message_status

  # For InboundSms controller, create
  post '/inbound_sms',     to: 'inbound_sms#create', as: :inbound_sms

  # For OutboundCall controller, new & create & show
  resources :outbound_calls, only: [:new, :create, :show]
end
