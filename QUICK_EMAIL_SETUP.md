# 📧 Email Feature - Quick Reference Card

## ✅ FEATURE IMPLEMENTED
Your Face Recognition Attendance System now sends automated emails!

## 🚀 GETTING STARTED (2 OPTIONS)

### Option 1: Interactive Setup (Easiest) ⭐
```bash
cd "/Users/harsha/Desktop/ai face"
./setup_email.sh
```
Prompts you through email provider selection and setup.

### Option 2: Quick Gmail Setup
```bash
# 1. Enable 2FA: https://myaccount.google.com/security
# 2. Get App Password: https://myaccount.google.com/apppasswords
# 3. Set variables:
export MAIL_USERNAME="your-email@gmail.com"
export MAIL_PASSWORD="your-app-password"
export MAIL_SERVER="smtp.gmail.com"
export MAIL_PORT="587"
export MAIL_USE_TLS="True"

# 4. Restart backend
cd "/Users/harsha/Desktop/ai face/backend"
python3 app.py &
```

## 📧 THREE AUTOMATIC EMAILS

| When | Email Goes To | Contains |
|------|---------------|----------|
| **Registration** | Employee email | Welcome, registration details, instructions |
| **Check-In** | Employee email | Confirmation, time, status, method |
| **Check-Out** | Employee email | Confirmation, time, status |

## 🔧 EMAIL PROVIDERS SUPPORTED

- Gmail (recommended for testing)
- Outlook / Office 365
- SendGrid (for production)
- AWS SES (for production)
- Any SMTP server

## 📁 NEW FILES CREATED

```
backend/email_service.py       - Email sending code
backend/.env.example           - Configuration template
EMAIL_SETUP.md                 - Detailed setup guide
EMAIL_FEATURES.md              - Full documentation
EMAIL_COMPLETE.md              - Complete summary
setup_email.sh                 - Interactive setup script
test_email.sh                  - Testing tool
```

## 🔄 FILES MODIFIED

```
backend/requirements.txt        - Added Flask-Mail
backend/config.py              - Added email settings
backend/app.py                 - Integrated email sending
```

## 🧪 TESTING

```bash
# Test configuration
bash test_email.sh

# Test registration email
1. Register employee with test email
2. Check email inbox

# Test attendance email
1. Mark attendance
2. Check email for notification
```

## ⚙️ CONFIGURATION REFERENCE

### Gmail
```
Server: smtp.gmail.com
Port: 587
TLS: Yes
Username: your-email@gmail.com
Password: your-app-password (NOT regular password!)
```

### Outlook
```
Server: smtp-mail.outlook.com
Port: 587
TLS: Yes
Username: your-email@outlook.com
Password: your-password
```

### SendGrid
```
Server: smtp.sendgrid.net
Port: 587
TLS: Yes
Username: apikey
Password: SG.your-api-key
```

## 🔒 SECURITY

- Never commit `.env` with real credentials
- Use environment variables for passwords
- Use app-specific passwords (Gmail)
- Enable 2FA on email account
- For production, use SendGrid/AWS SES

## 📞 TROUBLESHOOTING

### Emails not sending?
```bash
# Check configuration
echo $MAIL_USERNAME

# Check logs
tail -20 /tmp/backend.log

# Restart backend
lsof -ti:5001 | xargs kill -9 2>/dev/null || true
cd "/Users/harsha/Desktop/ai face/backend"
python3 app.py &
```

### "Authentication failed"?
- For Gmail: Ensure 2FA enabled and app password used (not regular password)
- Verify credentials are correct
- Check provider documentation

### Emails in spam?
- Mark as "Not Spam" in email client
- Add sender to contacts
- For production, use professional email service

## 📖 DOCUMENTATION

- `EMAIL_SETUP.md` - Step-by-step setup
- `EMAIL_FEATURES.md` - Complete feature guide
- `EMAIL_COMPLETE.md` - Implementation details
- `backend/.env.example` - Configuration template

## ✅ VERIFICATION

System Status:
- ✅ Backend running (port 5001)
- ✅ Email module integrated
- ✅ Flask-Mail installed
- ⏳ Configuration pending (run setup_email.sh)
- ✅ Ready for testing

## 🎯 NEXT STEPS

1. Run: `./setup_email.sh`
2. Register test employee
3. Check email for confirmation
4. Mark attendance
5. Check email for notification
6. System ready for production!

---
**Need Help?** Check EMAIL_SETUP.md or EMAIL_FEATURES.md
