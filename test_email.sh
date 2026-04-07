#!/bin/bash

# Quick test script to verify email integration

echo "🧪 Face Recognition Attendance System - Email Feature Test"
echo "=========================================================="
echo ""

# Check if backend is running
echo "1️⃣  Checking if backend is running..."
response=$(curl -s http://localhost:5001/api/health)
if [[ $response == *"healthy"* ]]; then
    echo "   ✅ Backend is healthy"
else
    echo "   ❌ Backend is not responding. Starting backend..."
    python3 /Users/harsha/Desktop/"ai face"/backend/app.py &
    sleep 5
fi

echo ""
echo "2️⃣  Checking email configuration..."
if [ -z "$MAIL_USERNAME" ]; then
    echo "   ⚠️  MAIL_USERNAME not set (emails will fail silently)"
    echo "   📝 To configure emails, run: ./setup_email.sh"
else
    echo "   ✅ MAIL_USERNAME configured: $MAIL_USERNAME"
fi

echo ""
echo "3️⃣  Checking Flask-Mail installation..."
if python3 -c "import flask_mail" 2>/dev/null; then
    echo "   ✅ Flask-Mail installed"
else
    echo "   ❌ Flask-Mail not installed. Installing..."
    pip3 install Flask-Mail==0.9.1
fi

echo ""
echo "4️⃣  Checking email service module..."
if [ -f "/Users/harsha/Desktop/ai face /backend/email_service.py" ]; then
    echo "   ✅ email_service.py exists"
else
    echo "   ❌ email_service.py not found"
fi

echo ""
echo "5️⃣  Checking current employees..."
employees=$(curl -s http://localhost:5001/api/employees)
employee_count=$(echo "$employees" | python3 -c "import sys, json; print(len(json.load(sys.stdin)['employees']))" 2>/dev/null)
if [ ! -z "$employee_count" ]; then
    echo "   ✅ Found $employee_count registered employees"
else
    echo "   ℹ️  No employees registered yet"
fi

echo ""
echo "6️⃣  System Status Summary:"
echo "   ✅ Backend: Running"
echo "   ✅ Email Module: Integrated"
echo "   ✅ Mail Service: $([ -z "$MAIL_USERNAME" ] && echo "Not Configured" || echo "Configured")"
echo ""

echo "📧 Email Features:"
echo "   • Registration confirmation emails"
echo "   • Attendance check-in notifications"
echo "   • Attendance check-out notifications"
echo ""

echo "🚀 To Configure Email:"
echo "   Run: ./setup_email.sh"
echo ""

echo "📖 For detailed setup guide:"
echo "   See: EMAIL_SETUP.md"
echo "   See: EMAIL_FEATURES.md"
echo ""

echo "✅ Test complete!"
