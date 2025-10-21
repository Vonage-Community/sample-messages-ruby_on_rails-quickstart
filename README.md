# Vonage APIs Quickstart Examples for Ruby on Rails
<br>

The purpose of the quickstart guide is to provide simple examples, each focused on one goal. For example, sending an SMS, making a Text to Speech call, or sending an image in WhatsApp. All using Vonage APIs.

## Configure with Your Vonage API Keys
<br>

To use this sample you will first need a [Vonage account](https://dashboard.vonage.com/sign-up). Once you have your own API credentials, rename the `.env.example` file to `.env` and set the values as required.

For some of the examples you will need to [buy a number](https://dashboard.vonage.com/buy-numbers).

## Setup
<br>

```
git clone git@github.com:Vonage-Community/sample-messages-ruby_on_rails-quickstart.git
cd sample-messages-ruby_on_rails-quickstart
cp .env.example .env
bundle install
rails db:create db:migrate
rails s
```

## Tutorials & Sample Code

### SMS
<br>

Tutorial                                                                                                                                                        | Code Sample
--------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------
[How to Send SMS Messages with Ruby on Rails](https://developer.vonage.com/en/blog/send-sms-ruby-on-rails-dr)                            | [outbound_sms_controller.rb](app/controllers/outbound_sms_controller.rb)
[Receive an SMS Message Status with Ruby on Rails](#) | [sms_message_status_controller.rb](app/controllers/sms_message_status_controller.rb)
[How to Receive SMS Messages with Ruby on Rails](https://developer.vonage.com/en/blog/receive-sms-messages-ruby-on-rails-dr)                      | [inbound_sms_controller.rb](app/controllers/inbound_sms_controller.rb)

### Voice
<br>

Tutorial                                                                                                                                                           | Code Sample
------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------
[How to Make an Outbound Text-to-Speech Phone Call with Rails](#)   | [outbound_calls_controller.rb](app/controllers/outbound_calls_controller.rb)
[How to receive an Call Event webhook with Ruby on Rails](#) | [call_events_controller.rb](app/controllers/call_events_controller.rb)
[How to Handle Inbound Phone Calls with Ruby on Rails](#)         | [inbound_calls_controller.rb](app/controllers/inbound_calls_controller.rb)

### RCS
<br>

Tutorial                                                                                                                                                        | Code Sample
--------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------
[How to Send RCS Suggested Reply Messages with Ruby on Rails](#)                            | [outbound_rcs_controller.rb](app/controllers/outbound_rcs_controller.rb)
[Receive an RCS Message Status with Ruby on Rails](#) | [rcs_message_status_controller.rb](app/controllers/rcs_message_status_controller.rb)
[How to Receive RCS Reply Messages with Ruby on Rails](#)                            | [inbound_rcs_controller.rb](app/controllers/inbound_rcs_controller.rb)

### WhatsApp
<br>

Tutorial                                                                                                                                                        | Code Sample
--------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------
[How to Send WhatsApp Messages with Ruby on Rails](#)                            | [outbound_whatsapp_controller.rb](app/controllers/outbound_whatsapp_controller.rb)
[How to Receive WhatsApp Messages with Ruby on Rails](#)                            | [inbound_whatsapp_controller.rb](app/controllers/inbound_whatsapp_controller.rb)

## Request More Examples
<br>

For help with the code or to request an example not listed here, please join the [Vonage Community Slack](https://developer.vonage.com/en/community/slack). Feedback and requests are highly appreciated!

## Licenses
<br>

- The code samples in this repo is under [MIT](LICENSE)

- The tutorials contents are under Creative Commons, [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode)

  ​
