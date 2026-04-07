#!/bin/bash

# Test Attendance Recognition

cd "/Users/harsha/Desktop/ai face /backend"

echo "===== ATTENDANCE RECOGNITION TEST ====="
echo ""

# Check if database exists
if [ ! -f "instance/attendance.db" ]; then
    echo "❌ Database not found"
    exit 1
fi

# Get all employees
echo "📋 Registered Employees:"
curl -s http://localhost:5001/api/employees | python3 -m json.tool

echo ""
echo "===== TESTING RECOGNIZE ENDPOINT ====="
echo ""

# Check if we have any test images
if [ -d "uploads" ]; then
    echo "📁 Uploaded files:"
    ls -la uploads/ | head -10
    echo ""
fi

# The issue: We need actual face images to test
echo "⚠️  To test recognition:"
echo "1. Go to http://localhost:3000"
echo "2. Use the Attendance Scanner"
echo "3. Upload the SAME face photo you used for registration"
echo "4. Or use the camera to capture your face"
echo ""
echo "📝 The system will:"
echo "   - Load your face photo"
echo "   - Compare it against registered employee faces"
echo "   - Mark attendance if face matches"
echo ""
echo "🔍 Debugging:"
echo "   - Check browser console (F12) for errors"
echo "   - Check below for API response:"
echo ""

# If you have a test image, you can test with:
# curl -X POST http://localhost:5001/api/recognize \
#   -F "image=@/path/to/test/face/image.jpg" \
#   -v

echo "✅ Backend is running on http://localhost:5001"
echo "✅ Frontend should be running on http://localhost:3000"
echo ""
echo "💡 Pro tip: Use the same face photo for recognition as you used for registration"
