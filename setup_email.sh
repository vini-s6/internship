#!/bin/bash

# Email Configuration Setup Script for Face Recognition Attendance System

echo "🔧 Email Configuration Setup"
echo "============================"
echo ""

# Display current configuration
echo "Current Configuration:"
echo "- MAIL_SERVER: ${MAIL_SERVER:-smtp.gmail.com}"
echo "- MAIL_PORT: ${MAIL_PORT:-587}"
echo "- MAIL_USERNAME: ${MAIL_USERNAME:-not-set}"
echo ""

# Ask user for email provider
echo "Select your email provider:"
echo "1. Gmail (recommended)"
echo "2. Outlook/Office 365"
echo "3. SendGrid"
echo "4. AWS SES"
echo "5. Custom"
echo ""
read -p "Enter choice (1-5): " provider_choice

case $provider_choice in
    1)
        echo "Gmail selected!"
        echo ""
        echo "📌 Gmail Setup Instructions:"
        echo "1. Go to https://myaccount.google.com/security"
        echo "2. Enable 2-Step Verification"
        echo "3. Go to https://myaccount.google.com/apppasswords"
        echo "4. Select 'Mail' and 'Windows Computer'"
        echo "5. Copy the 16-character password"
        echo ""
        read -p "Enter your Gmail address: " gmail_address
        read -sp "Enter your App Password (16 chars): " app_password
        echo ""
        
        export MAIL_SERVER="smtp.gmail.com"
        export MAIL_PORT="587"
        export MAIL_USE_TLS="True"
        export MAIL_USERNAME="$gmail_address"
        export MAIL_PASSWORD="$app_password"
        export MAIL_DEFAULT_SENDER="noreply@attendance-system.com"
        ;;
    2)
        echo "Outlook selected!"
        read -p "Enter Outlook email: " outlook_email
        read -sp "Enter password: " outlook_pass
        echo ""
        
        export MAIL_SERVER="smtp-mail.outlook.com"
        export MAIL_PORT="587"
        export MAIL_USE_TLS="True"
        export MAIL_USERNAME="$outlook_email"
        export MAIL_PASSWORD="$outlook_pass"
        export MAIL_DEFAULT_SENDER="noreply@attendance-system.com"
        ;;
    3)
        echo "SendGrid selected!"
        read -p "Enter SendGrid API Key: " sendgrid_key
        
        export MAIL_SERVER="smtp.sendgrid.net"
        export MAIL_PORT="587"
        export MAIL_USE_TLS="True"
        export MAIL_USERNAME="apikey"
        export MAIL_PASSWORD="$sendgrid_key"
        export MAIL_DEFAULT_SENDER="noreply@attendance-system.com"
        ;;
    4)
        echo "AWS SES selected!"
        read -p "Enter SES SMTP endpoint: " ses_endpoint
        read -p "Enter SES username: " ses_user
        read -sp "Enter SES password: " ses_pass
        echo ""
        
        export MAIL_SERVER="$ses_endpoint"
        export MAIL_PORT="587"
        export MAIL_USE_TLS="True"
        export MAIL_USERNAME="$ses_user"
        export MAIL_PASSWORD="$ses_pass"
        export MAIL_DEFAULT_SENDER="noreply@attendance-system.com"
        ;;
    5)
        echo "Custom provider selected!"
        read -p "Enter SMTP server: " custom_server
        read -p "Enter SMTP port: " custom_port
        read -p "Enter email username: " custom_user
        read -sp "Enter email password: " custom_pass
        echo ""
        
        export MAIL_SERVER="$custom_server"
        export MAIL_PORT="$custom_port"
        export MAIL_USE_TLS="True"
        export MAIL_USERNAME="$custom_user"
        export MAIL_PASSWORD="$custom_pass"
        export MAIL_DEFAULT_SENDER="noreply@attendance-system.com"
        ;;
    *)
        echo "Invalid choice!"
        exit 1
        ;;
esac

echo ""
echo "✅ Configuration set!"
echo ""
echo "Environment variables saved in current session."
echo ""
echo "📝 To make these permanent, add to ~/.zshrc or ~/.bash_profile:"
echo ""
echo "export MAIL_SERVER=\"$MAIL_SERVER\""
echo "export MAIL_PORT=\"$MAIL_PORT\""
echo "export MAIL_USE_TLS=\"$MAIL_USE_TLS\""
echo "export MAIL_USERNAME=\"$MAIL_USERNAME\""
echo "export MAIL_PASSWORD=\"$MAIL_PASSWORD\""
echo "export MAIL_DEFAULT_SENDER=\"$MAIL_DEFAULT_SENDER\""
echo ""
echo "🔄 Restarting backend..."
echo ""

# Kill old backend process
lsof -ti:5001 | xargs kill -9 2>/dev/null || true
sleep 2

# Start backend
cd "$(dirname "$0")/backend" || exit
python3 app.py &

echo "✅ Backend restarted with email configuration!"
echo ""
echo "The system will now send emails for:"
echo "  📧 Employee registration confirmation"
echo "  📧 Attendance check-in notifications"
echo "  📧 Attendance check-out notifications"
