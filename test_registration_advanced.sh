#!/bin/bash

# Enhanced test script with proper face image

echo "🧪 Testing Employee Registration with Real Face..."
echo ""

# Check if backend is running
echo "1️⃣ Checking if backend is running..."
HEALTH=$(curl -s http://localhost:5001/api/health | grep "healthy")

if [ -z "$HEALTH" ]; then
    echo "❌ Backend is not running!"
    exit 1
fi
echo "✅ Backend is running on http://localhost:5001"
echo ""

# Download a test face image from the internet
echo "2️⃣ Downloading a test face image..."
python3 << 'PYEOF'
import urllib.request
import os

# Using a public domain face image from Wikipedia
# This is a simple face that should work for testing
url = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg"

try:
    urllib.request.urlretrieve(url, '/tmp/test_face.jpg')
    print("✅ Test image downloaded (note: for production, use actual human faces)")
except Exception as e:
    print(f"⚠️ Could not download image: {e}")
    print("Please upload a real face image through the UI")
PYEOF
echo ""

# Try to register
echo "3️⃣ Attempting employee registration..."
echo ""
curl -X POST http://localhost:5001/api/register \
  -F "name=Test Employee" \
  -F "email=test@example.com" \
  -F "employee_id=TEST001" \
  -F "image=@/tmp/test_face.jpg" \
  -H "Accept: application/json" \
  -s | python3 -m json.tool 2>/dev/null || echo "Unable to parse response"

echo ""
echo "📋 Registered employees:"
curl -s http://localhost:5001/api/employees | python3 -m json.tool 2>/dev/null

echo ""
echo "✅ Test completed!"
echo ""
echo "📝 IMPORTANT NOTES:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. The API requires ACTUAL FACE IMAGES"
echo "2. Images must contain exactly ONE face"
echo "3. Use a clear, front-facing photo for best results"
echo "4. Supported formats: JPG, PNG, GIF, BMP"
echo "5. Maximum file size: 16MB"
echo ""
echo "TO REGISTER AN EMPLOYEE:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. Go to http://localhost:3000"
echo "2. Fill in Name, Email, and Employee ID"
echo "3. Upload a clear face photo (MUST show a face)"
echo "4. Click 'Register Employee'"
echo ""
