═══════════════════════════════════════════════════════════════════════
                📧 EMAIL NOTIFICATIONS FEATURE GUIDE
═══════════════════════════════════════════════════════════════════════

✨ NEW FEATURE: Employees receive professional emails when:
   
   1. They register for the first time
      → Registration confirmation with welcome message
   
   2. They mark attendance (check-in)
      → Check-in confirmation with timestamp
   
   3. They check out (mark attendance again)
      → Check-out confirmation with timestamp

═══════════════════════════════════════════════════════════════════════

🚀 SETUP IN 2 MINUTES (Choose One Option):

OPTION A: INTERACTIVE SETUP (Recommended for Beginners)
───────────────────────────────────────────────────────
$ cd "/Users/harsha/Desktop/ai face"
$ ./setup_email.sh

Then:
  1. Choose your email provider (Gmail, Outlook, SendGrid, etc.)
  2. Enter your email credentials
  3. Press Enter and system will configure everything
  4. Backend will restart automatically

OPTION B: MANUAL SETUP (For Gmail)
──────────────────────────────────
Step 1: Enable 2-Factor Authentication
   → Visit: https://myaccount.google.com/security
   → Enable "2-Step Verification"

Step 2: Generate App Password
   → Visit: https://myaccount.google.com/apppasswords
   → Select "Mail" and "Windows Computer"
   → Copy the 16-character password shown

Step 3: Set Environment Variables
   $ export MAIL_USERNAME="your-email@gmail.com"
   $ export MAIL_PASSWORD="your-app-password"
   $ export MAIL_SERVER="smtp.gmail.com"
   $ export MAIL_PORT="587"
   $ export MAIL_USE_TLS="True"

Step 4: Restart Backend
   $ cd "/Users/harsha/Desktop/ai face/backend"
   $ python3 app.py &

═══════════════════════════════════════════════════════════════════════

✅ EMAIL PROVIDERS SUPPORTED:

Gmail (FREE - Best for Testing)
   Server: smtp.gmail.com
   Port: 587
   Setup: 5 minutes
   Cost: Free

Outlook/Office 365 (FREE - If you have account)
   Server: smtp-mail.outlook.com
   Port: 587
   Setup: 3 minutes
   Cost: Free

SendGrid (PAID - Production Quality)
   Server: smtp.sendgrid.net
   Port: 587
   Setup: 10 minutes
   Cost: Free tier + paid plans

AWS SES (PAID - For Large Scale)
   Server: email-smtp.region.amazonaws.com
   Port: 587
   Setup: 15 minutes
   Cost: Starts from $0.10 per 1000 emails

═══════════════════════════════════════════════════════════════════════

📧 SAMPLE EMAILS YOUR EMPLOYEES WILL RECEIVE:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EMAIL 1: REGISTRATION CONFIRMATION

From: noreply@attendance-system.com
To: john@company.com
Subject: ✅ Employee Registration Successful

Dear John Doe,

You have been successfully registered in the Face Recognition 
Attendance System!

Registration Details:
- Name: John Doe
- Employee ID: EMP001
- Registration Time: 2026-02-05 18:30:00

Your face has been encoded and stored. You can now use the system
to mark attendance.

How to use:
1. Open the Mark Attendance section
2. Allow camera access
3. Face the camera
4. Your attendance is recorded!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EMAIL 2: CHECK-IN NOTIFICATION

From: noreply@attendance-system.com
To: john@company.com
Subject: 🔓 Attendance Checked In - 2026-02-05

Dear John Doe,

Your attendance has been recorded successfully!

Details:
- Name: John Doe
- Checked In Time: 2026-02-05 09:15:32
- Status: Present
- Method: Face Recognition

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EMAIL 3: CHECK-OUT NOTIFICATION

From: noreply@attendance-system.com
To: john@company.com
Subject: 🔐 Attendance Checked Out - 2026-02-05

Dear John Doe,

Your check-out has been recorded successfully!

Details:
- Name: John Doe
- Checked Out Time: 2026-02-05 18:30:15
- Status: Present

═══════════════════════════════════════════════════════════════════════

🧪 TEST YOUR SETUP:

1. Run the diagnostic tool:
   $ cd "/Users/harsha/Desktop/ai face"
   $ bash test_email.sh

2. Test registration email:
   a. Go to http://localhost:3000
   b. Click "Register Employee"
   c. Use YOUR email address for testing
   d. Complete registration
   e. Check your email for confirmation
   f. If not found, check spam folder

3. Test attendance email:
   a. Go back to app
   b. Click "Mark Attendance"
   c. Mark attendance with camera/photo
   d. Check email for notification

═══════════════════════════════════════════════════════════════════════

📁 WHAT WAS ADDED TO YOUR SYSTEM:

New Files Created:
  backend/email_service.py          → Email sending functions
  backend/.env.example              → Configuration template
  EMAIL_SETUP.md                    → Detailed setup guide
  EMAIL_FEATURES.md                 → Complete documentation
  QUICK_EMAIL_SETUP.md              → Quick reference
  setup_email.sh                    → Interactive setup tool
  test_email.sh                     → Testing tool

Files Modified:
  backend/requirements.txt           → Added Flask-Mail library
  backend/config.py                 → Added email settings
  backend/app.py                    → Email integration code

═══════════════════════════════════════════════════════════════════════

⚙️ CONFIGURATION AFTER SETUP:

To change email settings later:
   Option 1: Edit and re-run ./setup_email.sh
   Option 2: Edit environment variables directly
   Option 3: Edit backend/.env file (if you created one)

Current Status:
   Backend: ✅ Running on port 5001
   Email Module: ✅ Integrated and ready
   Configuration: ⏳ Awaiting setup (run setup_email.sh)
   Frontend: ✅ Working as usual

═══════════════════════════════════════════════════════════════════════

❓ TROUBLESHOOTING:

Problem: "Emails not sending"
Solution:
   1. Check configuration: echo $MAIL_USERNAME
   2. Verify backend restarted
   3. Check backend logs: tail -20 /tmp/backend.log
   4. Run diagnostic: bash test_email.sh

Problem: "Gmail authentication failed"
Solution:
   1. Make sure 2FA is enabled
   2. Use App Password (NOT regular password)
   3. Copy full 16-character password with no spaces

Problem: "Connection refused"
Solution:
   1. Check email server is correct
   2. Verify port number (usually 587)
   3. Check internet connection
   4. Try different email provider

Problem: "Emails in spam folder"
Solution:
   1. Mark as "Not Spam" in email
   2. Add sender to contacts
   3. For production, use professional email service

═══════════════════════════════════════════════════════════════════════

📖 DOCUMENTATION & HELP:

Quick Reference:
   See: QUICK_EMAIL_SETUP.md

Complete Setup Guide:
   See: EMAIL_SETUP.md

Full Feature Documentation:
   See: EMAIL_FEATURES.md

Technical Details:
   See: EMAIL_COMPLETE.md or IMPLEMENTATION_SUMMARY.md

═══════════════════════════════════════════════════════════════════════

🎯 NEXT STEPS:

1. Run the interactive setup:
   $ ./setup_email.sh

2. Choose your email provider

3. Enter your credentials

4. System will restart automatically

5. Test by registering an employee

6. Check your email for confirmation!

═══════════════════════════════════════════════════════════════════════

🎉 YOU'RE ALL SET!

Your Face Recognition Attendance System now has professional email
notifications! Employees will receive beautiful confirmation emails
for registration, check-in, and check-out.

Ready to deploy! 🚀

═══════════════════════════════════════════════════════════════════════
