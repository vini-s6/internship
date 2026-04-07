# Email Notifications Feature - Complete Setup

## 🎯 Feature Overview

Your Face Recognition Attendance System now includes **automated email notifications** for:

1. **✅ Employee Registration Confirmation**
   - Sent immediately after successful employee registration
   - Includes: Name, Employee ID, Email, Registration timestamp
   - Beautiful formatted HTML email with instructions

2. **📬 Attendance Check-in Notification**
   - Sent when employee marks attendance (check-in)
   - Includes: Employee name, check-in time, status, method
   - Emoji-enhanced email for visual appeal

3. **🔐 Attendance Check-out Notification**
   - Sent when employee checks out
   - Includes: Employee name, check-out time, confirmation

## 🚀 Quick Setup (5 minutes)

### Method 1: Interactive Setup (Easiest)

```bash
cd "/Users/harsha/Desktop/ai face"
./setup_email.sh
```

This script will guide you through:
- Email provider selection
- Credentials entry
- Automatic backend restart

### Method 2: Manual Setup (Gmail)

1. **Enable 2FA on Gmail**
   - Visit: https://myaccount.google.com/security
   - Click "2-Step Verification"

2. **Generate App Password**
   - Visit: https://myaccount.google.com/apppasswords
   - Select "Mail" and "Windows Computer"
   - Copy the 16-character password

3. **Set Environment Variables**
   ```bash
   export MAIL_USERNAME="your-email@gmail.com"
   export MAIL_PASSWORD="your-16-char-app-password"
   export MAIL_SERVER="smtp.gmail.com"
   export MAIL_PORT="587"
   export MAIL_USE_TLS="True"
   ```

4. **Restart Backend**
   ```bash
   # Kill existing process
   lsof -ti:5001 | xargs kill -9 2>/dev/null || true
   
   # Start backend from backend folder
   cd "/Users/harsha/Desktop/ai face/backend"
   python3 app.py
   ```

## 📧 Email Provider Configuration

### Gmail (Recommended)
```
MAIL_SERVER=smtp.gmail.com
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
```

### Outlook/Office 365
```
MAIL_SERVER=smtp-mail.outlook.com
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=your-email@outlook.com
MAIL_PASSWORD=your-password
```

### SendGrid
```
MAIL_SERVER=smtp.sendgrid.net
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=apikey
MAIL_PASSWORD=SG.your-api-key-here
```

### AWS SES
```
MAIL_SERVER=email-smtp.region.amazonaws.com
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=your-ses-username
MAIL_PASSWORD=your-ses-password
```

## 🧪 Testing Email Configuration

### Test 1: Verify Backend is Running
```bash
curl http://localhost:5001/api/health
```
Expected response:
```json
{
  "status": "healthy",
  "message": "API is running"
}
```

### Test 2: Check Backend Logs
```bash
tail -20 /tmp/backend.log
```
Look for: `✅ Registration email sent to...` or `✅ Attendance email sent to...`

### Test 3: Register a Test Employee
1. Go to http://localhost:3000
2. Click "Register Employee"
3. Fill in details with test email
4. Complete registration
5. Check test email for confirmation email
6. Check spam folder if not found

### Test 4: Mark Attendance
1. Go to "Mark Attendance"
2. Mark attendance with camera/photo
3. Check email for attendance notification

## 📝 Files Added/Modified

### New Files Created:
- `backend/email_service.py` - Email sending functions
- `EMAIL_SETUP.md` - Detailed configuration guide
- `setup_email.sh` - Interactive setup script
- `EMAIL_FEATURES.md` - This file

### Modified Files:
- `backend/requirements.txt` - Added Flask-Mail
- `backend/config.py` - Added email configuration
- `backend/app.py` - Integrated email sending in registration and attendance

## 🔧 Configuration Files

### Current Email Config (`backend/config.py`)
```python
MAIL_SERVER = 'smtp.gmail.com'      # Can be changed
MAIL_PORT = 587                     # Can be changed
MAIL_USE_TLS = True                 # Can be changed
MAIL_USERNAME = 'your-email@gmail.com'  # Set via env var
MAIL_PASSWORD = 'your-app-password'     # Set via env var
MAIL_DEFAULT_SENDER = 'noreply@attendance-system.com'
```

### Environment Variables (Secure Storage)
```bash
MAIL_USERNAME      # Your email address
MAIL_PASSWORD      # Your app-specific password
MAIL_SERVER        # SMTP server address
MAIL_PORT          # SMTP port (usually 587)
MAIL_USE_TLS       # Use TLS encryption (True/False)
```

## 🎨 Email Templates

### Registration Email
- Header: "✅ Employee Registration Successful"
- Includes: Employee details and system instructions
- Color scheme: Blue/Purple gradient
- Call-to-action: Guide to mark attendance

### Attendance Email
- Header: "🔓 Attendance Checked In" or "🔐 Attendance Checked Out"
- Includes: Employee name, timestamp, status
- Color scheme: Green success indicators
- Auto-generated: Based on check-in/check-out

## ⚠️ Troubleshooting

### Problem: "SMTPAuthenticationError"
**Solution:** 
- Verify MAIL_USERNAME and MAIL_PASSWORD
- For Gmail, ensure App Password (not regular password)
- Check that 2FA is enabled on Gmail account

### Problem: "Connection refused"
**Solution:**
- Verify MAIL_SERVER is correct
- Check internet connection
- Verify MAIL_PORT is not blocked by firewall

### Problem: "Emails not sending"
**Solution:**
- Check backend logs: `tail -f /tmp/backend.log`
- Look for error messages containing "Email"
- Verify email configuration is set before backend startup
- Try with different recipient email

### Problem: "Module 'email_service' not found"
**Solution:**
- Ensure backend was restarted after adding email_service.py
- Check file exists: `ls backend/email_service.py`
- Verify Flask-Mail installed: `pip3 list | grep Flask-Mail`

## 📊 Email Features in Action

### When Employee Registers:
```
1. User fills registration form with camera/photo
2. Face encoding completed ✓
3. Employee record saved ✓
4. EMAIL SENT: Registration confirmation
5. User sees success message
```

### When Employee Marks Attendance:
```
1. User opens camera for face recognition
2. Face matched with database ✓
3. Attendance record created ✓
4. EMAIL SENT: Attendance check-in notification
5. User sees "Attendance marked successfully"
```

### When Employee Checks Out:
```
1. User captures face again same day
2. Face matched with database ✓
3. Check-out time recorded ✓
4. EMAIL SENT: Attendance check-out notification
5. User sees "Check-out recorded"
```

## 🔐 Security Considerations

1. **Never commit passwords** - Use environment variables
2. **Use App Passwords** - Generate specific app passwords for email (Gmail)
3. **Enable TLS** - Always use encrypted email transmission
4. **Restrict access** - Ensure backend is not publicly accessible
5. **Validate emails** - System validates email format on registration

## 🚀 Production Deployment

### For Production Use:
1. Use a dedicated email service (SendGrid, AWS SES, etc.)
2. Set strong, random passwords
3. Use environment variables for all credentials
4. Enable SSL/TLS
5. Set up email authentication (SPF, DKIM, DMARC)
6. Monitor email delivery rates
7. Set up bounce handling

### Recommended Production Providers:
- **SendGrid** - Easy setup, good deliverability
- **AWS SES** - Scalable, integrates with AWS
- **Mailgun** - Developer-friendly
- **Postmark** - Excellent support

## 📞 Support

If emails aren't working:

1. Check backend logs: `tail -30 /tmp/backend.log`
2. Verify configuration: `echo $MAIL_USERNAME`
3. Test SMTP connection: Use mail testing tools
4. Check email spam folder
5. Review email provider documentation

## ✅ Verification Checklist

- [ ] Flask-Mail installed: `pip3 list | grep Flask-Mail`
- [ ] email_service.py exists: `ls backend/email_service.py`
- [ ] config.py updated: Contains MAIL settings
- [ ] app.py updated: Imports email_service, calls send functions
- [ ] Environment variables set: `echo $MAIL_USERNAME`
- [ ] Backend restarted: Logs show "API is running"
- [ ] Test registration email received
- [ ] Test attendance email received

## 🎉 Feature Complete!

Your attendance system now automatically notifies employees about:
- ✅ Their registration status
- 📧 Every attendance check-in
- 📧 Every attendance check-out

All with professional, beautiful HTML emails! 🚀
