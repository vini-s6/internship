#!/bin/bash

# Debug script to diagnose registration issues

echo "🔍 REGISTRATION DEBUGGING TOOL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 1. Check backend
echo "1️⃣ Backend Status:"
if curl -s http://localhost:5001/api/health | grep -q "healthy"; then
    echo "   ✅ Backend is running"
else
    echo "   ❌ Backend is NOT running"
    echo "   Start with: cd /Users/harsha/Desktop/ai\ face\ /backend && python3 app.py"
    exit 1
fi
echo ""

# 2. Check database
echo "2️⃣ Database Status:"
if [ -f "/Users/harsha/Desktop/ai face /backend/attendance.db" ]; then
    echo "   ✅ Database file exists"
    sqlite3 "/Users/harsha/Desktop/ai face /backend/attendance.db" "SELECT COUNT(*) as employees FROM employees;" 2>/dev/null && echo "   ✅ Database tables exist"
else
    echo "   ⚠️  Database file not found - it will be created on first registration"
fi
echo ""

# 3. Check uploads directory
echo "3️⃣ Uploads Directory:"
if [ -d "/Users/harsha/Desktop/ai face /backend/uploads" ]; then
    echo "   ✅ Uploads directory exists"
    echo "   📂 Location: /Users/harsha/Desktop/ai face /backend/uploads"
else
    echo "   ❌ Uploads directory missing - creating..."
    mkdir -p "/Users/harsha/Desktop/ai face /backend/uploads"
fi
echo ""

# 4. Check frontend
echo "4️⃣ Frontend Status:"
if curl -s http://localhost:3000 | grep -q "face-recognition"; then
    echo "   ✅ Frontend is running"
else
    echo "   ⚠️  Frontend may not be running"
    echo "   Start with: cd /Users/harsha/Desktop/ai\ face\ /frontend && npm start"
fi
echo ""

# 5. Test API endpoints
echo "5️⃣ API Endpoints:"
echo "   Testing /api/health..."
curl -s -w "\n   Status: %{http_code}\n" -o /dev/null http://localhost:5001/api/health

echo "   Testing /api/employees..."
curl -s -w "   Status: %{http_code}\n" -o /dev/null http://localhost:5001/api/employees

echo "   Testing /api/attendance..."
curl -s -w "   Status: %{http_code}\n" -o /dev/null http://localhost:5001/api/attendance
echo ""

# 6. Check for common issues
echo "6️⃣ Common Issues:"

# Check if face_recognition library works
python3 << 'PYEOF' 2>/dev/null
import face_recognition
print("   ✅ face_recognition library is installed")
PYEOF

# Check Flask-SQLAlchemy
python3 -c "import flask_sqlalchemy; print('   ✅ Flask-SQLAlchemy is installed')" 2>/dev/null

# Check CORS
python3 -c "import flask_cors; print('   ✅ Flask-CORS is installed')" 2>/dev/null

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Diagnostic check complete!"
echo ""
echo "📋 NEXT STEPS:"
echo "1. Use the registration form at http://localhost:3000"
echo "2. Upload a real face photo (clear, front-facing)"
echo "3. If it fails, check browser console (F12) for error messages"
echo "4. Backend logs will show detailed error messages"
echo ""
