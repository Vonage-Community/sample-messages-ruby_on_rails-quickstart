# WhatsApp Integration Setup Guide

This guide will help you set up and use the WhatsApp messaging functionality that has been added to your Rails application.

## What Was Added

The following components have been integrated into your existing Rails app:

### 1. Database
- **Migration**: `db/migrate/20251015112429_create_whatsapp_messages.rb`
- **Model**: `app/models/whatsapp_message.rb`
- Stores WhatsApp message records with fields: `to`, `from`, `text`, `status`, `message_uuid`, `is_inbound`

### 2. Controller
- **File**: `app/controllers/outbound_whatsapp_controller.rb`
- **Actions**:
  - `new` - Display the form for sending WhatsApp messages
  - `create` - Send a text WhatsApp message
  - `interactive` - Send an interactive WhatsApp message with reply buttons

### 3. View
- **File**: `app/views/outbound_whatsapp/new.html.erb`
- Contains forms for both text and interactive WhatsApp messages

### 4. Routes
Added to `config/routes.rb`:
```ruby
get  '/outbound_whatsapp/new', to: 'outbound_whatsapp#new', as: :new_outbound_whatsapp
post '/outbound_whatsapp',     to: 'outbound_whatsapp#create', as: :outbound_whatsapp
post '/outbound_whatsapp/interactive', to: 'outbound_whatsapp#interactive', as: :interactive_whatsapp
```

### 5. Environment Configuration
Added `VONAGE_WHATSAPP_NUMBER` to `.env.example`

## Setup Instructions

### Step 1: Run the Migration
```bash
rails db:migrate
```

### Step 2: Configure Your Vonage WhatsApp Application

1. Log in to your [Vonage Dashboard](https://dashboard.nexmo.com/)
2. Create a new application (or use an existing one) and enable the **Messages** capability
3. Add webhook URLs for:
   - **Inbound**: `https://your-domain.com/inbound` (or use ngrok for testing)
   - **Status**: `https://your-domain.com/status`
4. Click **Generate public and private key**
5. Move the downloaded `private.key` file to the root of your Rails app
6. Note your **Application ID**
7. Click **Save**
8. Under the **Link external accounts** tab, link your WhatsApp number

### Step 3: Update Your .env File

Add the following to your `.env` file (create one if it doesn't exist):

```bash
VONAGE_APPLICATION_ID=your_application_id_here
VONAGE_PRIVATE_KEY=./private.key
VONAGE_WHATSAPP_NUMBER=14157386102  # Your WhatsApp Business number
```

### Step 4: Test the Integration

1. Start your Rails server:
   ```bash
   rails s
   ```

2. Navigate to: `http://localhost:3000/outbound_whatsapp/new`

3. You should see two forms:
   - **Send a WhatsApp Message** - For sending text messages
   - **Try an Interactive Message** - For sending messages with reply buttons

## Features

### Text Messages
Send simple text messages to any WhatsApp number. The form includes:
- **From**: Your WhatsApp Business number (pre-filled from ENV)
- **To**: Recipient's WhatsApp number (format: +14155551234)
- **Message**: The text content to send

### Interactive Messages
Send messages with reply buttons that users can tap to respond. The example includes:
- A header ("Delivery time")
- Body text with a question
- Footer text with additional info
- Three reply buttons with different time slots

You can customize the interactive message structure in the `interactive` action of `OutboundWhatsappController`.

## How It Works

1. **User fills out the form** and submits
2. **Controller receives the data** and creates a `WhatsappMessage` record
3. **Vonage client is initialized** with your credentials
4. **Message is sent** via the Vonage Messages API
5. **Response is checked** - if successful (HTTP 202), the `message_uuid` is saved
6. **User is redirected** back to the form with a success notice

## Next Steps

As mentioned in the tutorial, this implementation covers sending messages. To build a complete WhatsApp integration, you'll want to add:

1. **Inbound message handling** - Receive messages from users
2. **Status webhooks** - Track message delivery and read status
3. **Interactive response handling** - Process which button the user clicked

These features would require additional controllers and webhook endpoints, similar to the existing `inbound_sms` and `sms_message_status` controllers in your app.

## Troubleshooting

- **Make sure your WhatsApp number is linked** to your Vonage application
- **Verify your .env file** has the correct credentials
- **Check that private.key** is in the root directory
- **Ensure the recipient number** is in E.164 format (e.g., +14155551234)
- **For testing**, you can use the [Vonage Sandbox for WhatsApp](https://developer.vonage.com/en/messages/concepts/messages-api-sandbox)

## Resources

- [Vonage Messages API Documentation](https://developer.vonage.com/en/messages/overview)
- [WhatsApp Business API Guide](https://developer.vonage.com/en/messages/concepts/whatsapp)
- [Vonage Ruby SDK](https://github.com/Vonage/vonage-ruby-sdk)
