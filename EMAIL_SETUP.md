# Email Configuration Guide

## Overview
The system now sends automated emails for:
1. ✅ Employee Registration Confirmation
2. 📬 Attendance Check-in Notifications
3. 🔐 Attendance Check-out Notifications

## Email Configuration

### Option 1: Gmail (Recommended for Testing)

#### Step 1: Enable 2FA on Gmail
- Go to https://myaccount.google.com/security
- Enable 2-Step Verification

#### Step 2: Generate App Password
- Go to https://myaccount.google.com/apppasswords
- Select "Mail" and "Windows Computer"
- Copy the generated 16-character password

#### Step 3: Set Environment Variables
Run these commands in the terminal:

```bash
export MAIL_USERNAME="your-email@gmail.com"
export MAIL_PASSWORD="your-app-password-here"
export MAIL_SERVER="smtp.gmail.com"
export MAIL_PORT="587"
export MAIL_USE_TLS="True"
export MAIL_DEFAULT_SENDER="noreply@attendance-system.com"
```

Or create a `.env` file in the backend directory:
```
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password-here
MAIL_SERVER=smtp.gmail.com
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_DEFAULT_SENDER=noreply@attendance-system.com
```

### Option 2: Other Email Providers

#### Outlook/Office 365
```
MAIL_SERVER=smtp-mail.outlook.com
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=your-email@outlook.com
MAIL_PASSWORD=your-password
```

#### SendGrid
```
MAIL_SERVER=smtp.sendgrid.net
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=apikey
MAIL_PASSWORD=your-sendgrid-api-key
```

#### AWS SES
```
MAIL_SERVER=email-smtp.region.amazonaws.com
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=your-ses-username
MAIL_PASSWORD=your-ses-password
```

## Restart Backend

After configuring email, restart the backend:

```bash
# Kill old process
lsof -ti:5001 | xargs kill -9 2>/dev/null || true

# Start backend
cd /Users/harsha/Desktop/"ai face"/backend
python3 app.py
```

## Email Features

### Registration Email
When an employee registers:
- ✅ Welcome message
- 📋 Registration details (Name, Employee ID, Email, Registration Time)
- 📖 Instructions on how to use the system
- 🎯 Status confirmation

### Attendance Email
When attendance is marked:
- 🔓 Check-in notification with timestamp
- 🔐 Check-out notification with timestamp
- ✔ Status and method confirmation
- 📍 Employee details

## Testing Email Configuration

To test if email is working:

```python
# In Python terminal
from backend.email_service import send_registration_email, send_attendance_email

# Test registration email
send_registration_email("John Doe", "john@example.com", "EMP001")

# Test attendance email
send_attendance_email("John Doe", "john@example.com", "check-in")
```

## Troubleshooting

### "Connection refused" error
- Check if MAIL_SERVER is correct
- Verify MAIL_PORT is open
- For Gmail, ensure App Password is used (not regular password)

### "Authentication failed" error
- Verify MAIL_USERNAME and MAIL_PASSWORD are correct
- For Gmail, ensure 2FA is enabled and App Password is generated
- Check if email account allows SMTP access

### Emails not sending
- Check backend logs: `tail -f /tmp/backend.log`
- Verify email configuration is loaded: Check app startup logs
- Test with different email address
- Check if email ends up in spam folder

### SMTP Connection Timeout
- Check internet connection
- Verify firewall isn't blocking port 587 or MAIL_PORT
- Try different MAIL_SERVER

## Email Content Customization

To customize email templates, edit `/backend/email_service.py`:
- `send_registration_email()` function for registration emails
- `send_attendance_email()` function for attendance emails

Change the HTML templates in the `html=` parameter to customize:
- Subject line
- Email body
- Colors and styling
- Company name/logo
