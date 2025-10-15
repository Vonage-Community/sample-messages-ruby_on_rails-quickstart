Rails.application.routes.draw do
  get "inbound_rcs/create"
  
  # For RcsMessageStatus controller, create
  post '/rcs_message_status', to: 'rcs_message_status#create', as: :rcs_message_status


  # For OutboundRcs controller, new & create
  get  '/outbound_rcs/new', to: 'outbound_rcs#new',    as: :new_outbound_rcs
  post '/outbound_rcs',     to: 'outbound_rcs#create', as: :outbound_rcs
  post '/inbound_rcs',     to: 'inbound_rcs#create', as: :inbound_rcs
  

  # For OutboundSms controller, new & create
  get  '/outbound_sms/new', to: 'outbound_sms#new',    as: :new_outbound_sms
  post '/outbound_sms',     to: 'outbound_sms#create', as: :outbound_sms

  # For SmsMessageStatus controller, create
  post '/sms_message_status', to: 'sms_message_status#create', as: :sms_message_status

  # For InboundSms controller, create
  post '/inbound_sms',     to: 'inbound_sms#create', as: :inbound_sms

  # For OutboundCall controller, new & create & show
  resources :outbound_calls, only: [:new, :create, :show]
  
  # For CallEvents controller, create
  resources :call_events, only: [:create]
  
  # For InboundCalls controller, create
  resources :inbound_calls, only: [:create]

  # For OutboundWhatsapp controller, new & create & interactive
  get  '/outbound_whatsapp/new', to: 'outbound_whatsapp#new', as: :new_outbound_whatsapp
  post '/outbound_whatsapp',     to: 'outbound_whatsapp#create', as: :outbound_whatsapp
  post '/outbound_whatsapp/interactive', to: 'outbound_whatsapp#interactive', as: :interactive_whatsapp
end
