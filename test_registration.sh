#!/bin/bash

# Test script for Face Recognition Registration

echo "🧪 Testing Employee Registration API..."
echo ""

# Check if backend is running
echo "1️⃣ Checking if backend is running..."
HEALTH=$(curl -s http://localhost:5001/api/health | grep "healthy")

if [ -z "$HEALTH" ]; then
    echo "❌ Backend is not running!"
    echo "Start it with: cd /Users/harsha/Desktop/ai\ face\ /backend && python3 app.py"
    exit 1
fi
echo "✅ Backend is running"
echo ""

# Create a test image (simple 1x1 pixel PNG)
echo "2️⃣ Creating test image..."
python3 << 'PYEOF'
from PIL import Image
import os

# Create a simple test image
img = Image.new('RGB', (100, 100), color='blue')
img.save('/tmp/test_face.png')
print("✅ Test image created at /tmp/test_face.png")
PYEOF
echo ""

# Try to register with test data
echo "3️⃣ Attempting employee registration..."
curl -X POST http://localhost:5001/api/register \
  -F "name=John Doe" \
  -F "email=john@example.com" \
  -F "employee_id=EMP001" \
  -F "image=@/tmp/test_face.png" \
  -H "Accept: application/json" \
  -s | python3 -m json.tool

echo ""
echo "4️⃣ Checking registered employees..."
curl -s http://localhost:5001/api/employees | python3 -m json.tool

echo ""
echo "✅ Test completed!"
