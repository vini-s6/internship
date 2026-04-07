#!/bin/bash

# ATTENDANCE MARKING TEST GUIDE
# Database is ✅ healthy
# Backend is ✅ running on port 5001
# Employee "harsha" is ✅ registered with face encoding

echo "═══════════════════════════════════════════════════════"
echo "  ATTENDANCE MARKING - TROUBLESHOOTING & TEST GUIDE"
echo "═══════════════════════════════════════════════════════"
echo ""

# Check backend status
echo "🔍 CHECKING SYSTEM STATUS..."
echo ""

# Test health endpoint
if curl -s http://localhost:5001/api/health > /dev/null 2>&1; then
    echo "✅ Backend: Running on http://localhost:5001"
else
    echo "❌ Backend: NOT running"
    echo "   Start with: cd '/Users/harsha/Desktop/ai face /backend' && python3 app.py"
    exit 1
fi

# Check database
if [ -f "/Users/harsha/Desktop/ai face /backend/instance/attendance.db" ]; then
    echo "✅ Database: Exists at instance/attendance.db"
else
    echo "❌ Database: Not found"
    exit 1
fi

# Check registered employees
EMPLOYEE_COUNT=$(curl -s http://localhost:5001/api/employees | python3 -c "import sys, json; print(len(json.load(sys.stdin).get('employees', [])))" 2>/dev/null)
echo "✅ Registered Employees: $EMPLOYEE_COUNT"

echo ""
echo "═══════════════════════════════════════════════════════"
echo "  WHY ATTENDANCE MARKING MIGHT NOT BE WORKING"
echo "═══════════════════════════════════════════════════════"
echo ""

echo "1️⃣  FRONTEND NOT RUNNING"
echo "   Issue: You need to start the React frontend"
echo "   Fix: cd '/Users/harsha/Desktop/ai face /frontend' && npm start"
echo "   Then: Open http://localhost:3000 in browser"
echo ""

echo "2️⃣  NO PHOTO BEING UPLOADED"
echo "   Issue: AttendanceScanner not capturing/selecting photo"
echo "   Check:"
echo "     a) Can you click 'Use Camera' button?"
echo "     b) Can you click 'Upload Photo' button?"
echo "     c) Does file selector appear?"
echo "   Fix: Check browser console (F12) for JavaScript errors"
echo ""

echo "3️⃣  PHOTO NOT RECOGNIZED"
echo "   Issue: Face in photo doesn't match registered face"
echo "   Why:"
echo "     - Different angle/lighting than registration"
echo "     - Face too far/small in image"
echo "     - Image quality too low"
echo "   Fix: Use same face photo you used for registration"
echo "        Or take new photo with good lighting & clear face"
echo ""

echo "4️⃣  API ERROR RESPONSES"
echo "   Possible errors:"
echo "     ❌ 'No face detected' → Image has no face"
echo "     ❌ 'Multiple faces detected' → Image has 2+ people"
echo "     ❌ 'Face not recognized' → Face doesn't match"
echo "     ❌ 'No image provided' → File upload failed"
echo ""

echo "═══════════════════════════════════════════════════════"
echo "  HOW TO TEST STEP-BY-STEP"
echo "═══════════════════════════════════════════════════════"
echo ""

echo "STEP 1: Start Frontend"
echo "  cd '/Users/harsha/Desktop/ai face /frontend'"
echo "  npm start"
echo "  Wait for: 'Compiled successfully!'"
echo ""

echo "STEP 2: Open in Browser"
echo "  http://localhost:3000"
echo ""

echo "STEP 3: Go to 'Mark Attendance' Tab"
echo "  Click the 'Mark Attendance' tab"
echo ""

echo "STEP 4: Choose Photo Source"
echo "  Option A - Use Camera:"
echo "    - Click 'Use Camera' button"
echo "    - Allow camera access"
echo "    - Click 'Capture Photo' button"
echo "    - System will mark attendance"
echo ""
echo "  Option B - Upload Photo:"
echo "    - Click 'Upload Photo' button"
echo "    - Select the SAME face photo you used for registration"
echo "    - System will recognize face and mark attendance"
echo ""

echo "STEP 5: Check Results"
echo "  Success: Green alert showing employee name & check-in time"
echo "  Failure: Red error message (see error guide above)"
echo ""

echo "═══════════════════════════════════════════════════════"
echo "  CHECKING BACKEND LOGS"
echo "═══════════════════════════════════════════════════════"
echo ""

echo "Tail backend logs (real-time):"
echo "  tail -f /tmp/backend.log"
echo ""

echo "Recent backend logs:"
tail -20 /tmp/backend.log

echo ""
echo "═══════════════════════════════════════════════════════"
echo "  DATABASE HEALTH"
echo "═══════════════════════════════════════════════════════"
echo ""

cd "/Users/harsha/Desktop/ai face /backend" && python3 << 'PYTHONEOF'
import sqlite3
import json

conn = sqlite3.connect('instance/attendance.db')
cursor = conn.cursor()

# Employees
cursor.execute("SELECT id, name, email FROM employees")
employees = cursor.fetchall()
print(f"✅ Employees: {len(employees)}")
for emp_id, name, email in employees:
    print(f"   - {name} ({email})")

# Attendance
cursor.execute("SELECT COUNT(*) FROM attendance")
count = cursor.fetchone()[0]
print(f"✅ Attendance Records: {count}")

conn.close()
PYTHONEOF

echo ""
echo "═══════════════════════════════════════════════════════"
echo "  QUICK TEST WITH CURL"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "To test face recognition without UI:"
echo ""
echo "  curl -X POST http://localhost:5001/api/recognize \\"
echo "    -F 'image=@/path/to/your/face/photo.jpg'"
echo ""
echo "Success response should show:"
echo "  ✅ employee: {id, name, email, employee_id}"
echo "  ✅ attendance: {id, employee_id, check_in_time, date, status}"
echo ""
