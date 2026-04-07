# Employee Registration Fix Guide

## ✅ Issue Fixed

**Problem**: Photo upload registration was failing

**Root Causes Identified & Fixed**:
1. ❌ Axios was forcing `Content-Type: application/json` on FormData uploads
   - ✅ **Fixed**: Removed global content-type header to allow multipart/form-data
   
2. ❌ File `/frontend/src/services/api.js` wasn't properly handling file uploads
   - ✅ **Fixed**: Updated to use proper FormData without forced headers

## 📋 Current Status

✅ **Backend**: Running on port 5001
✅ **Frontend**: Ready on port 3000  
✅ **Database**: Initialized and ready
✅ **CORS**: Enabled for file uploads
✅ **All APIs**: Responding correctly (HTTP 200)
✅ **Dependencies**: All installed and working

## 🎯 How to Register an Employee

### Option 1: Using Web UI (Recommended)

1. Open http://localhost:3000 in your browser
2. Navigate to the "Register New Employee" tab
3. Fill in the form:
   - **Full Name**: Employee's name
   - **Email**: Valid email address
   - **Employee ID**: Unique employee identifier
   - **Upload Photo**: Click to select a face photo
4. Click "Register Employee"

### Option 2: Using cURL (For Testing)

```bash
curl -X POST http://localhost:5001/api/register \
  -F "name=John Doe" \
  -F "email=john@example.com" \
  -F "employee_id=EMP001" \
  -F "image=@/path/to/face_photo.jpg"
```

## ⚠️ Image Requirements

**MUST HAVE:**
- ✅ Exactly ONE face in the image
- ✅ Clear, front-facing photo
- ✅ Face visible and well-lit
- ✅ Actual human face (not drawing/cartoon)
- ✅ No extreme angles or shadows on face

**SUPPORTED FORMATS:**
- JPG / JPEG
- PNG
- GIF  
- BMP

**FILE SIZE:**
- Maximum: 16MB
- Recommended: 1-5MB for faster processing

**RESOLUTION:**
- Minimum: 100x100 pixels
- Recommended: 500x500+ pixels

## ❌ Common Issues & Solutions

### Issue 1: "No face detected in the image"
**Cause**: Image doesn't contain a face or face is too small/unclear
**Solution**: 
- Use a clear, front-facing photo
- Ensure face takes up at least 50% of the image
- Try a different angle or lighting

### Issue 2: "Multiple faces detected"
**Cause**: Image has more than one person
**Solution**:
- Use a photo with only ONE person
- Crop the image to show only one face

### Issue 3: "Email already exists"
**Cause**: Someone with this email is already registered
**Solution**:
- Use a different, unique email address

### Issue 4: "Employee ID already exists"  
**Cause**: This employee ID is already registered
**Solution**:
- Use a different, unique employee ID

### Issue 5: Network/CORS error in browser console
**Cause**: Frontend and backend not communicating
**Solution**:
- Verify backend is running: http://localhost:5001/api/health
- Check browser console (F12) for specific error
- Ensure both ports 3000 and 5001 are not blocked by firewall

## 📝 File Changes Made

```
/frontend/src/services/api.js
├─ Removed: Global Content-Type header
└─ Result: Axios now lets browser set proper multipart headers

/frontend/package.json
├─ Added: @emotion/react and @emotion/styled
└─ Result: Material-UI dependencies resolved
```

## ✅ Verification

Run the diagnostic tool to verify everything is working:

```bash
bash "/Users/harsha/Desktop/ai face /debug_registration.sh"
```

This will check:
- ✅ Backend is running
- ✅ Database is accessible
- ✅ Uploads directory exists
- ✅ All API endpoints respond
- ✅ Required libraries installed

## 🔧 If Still Having Issues

### Check Backend Logs
While terminal shows backend running, watch for error messages when registering

### Check Browser Console
Press F12 in browser and check Network and Console tabs:
1. Open DevTools (F12)
2. Go to Network tab
3. Try to register
4. Click on the failed request to see error response
5. Check Console tab for JavaScript errors

### Enable Debug Mode

Edit `/backend/app.py` to add more logging:
```python
@app.route('/api/register', methods=['POST'])
def register_employee():
    print(f"Form data: {request.form}")  # Add this
    print(f"Files: {request.files}")     # Add this
    # ... rest of code
```

### Test with Command Line

```bash
# Simple test without image
curl -X POST http://localhost:5001/api/employees

# Test with actual face image (requires a real photo at path)
curl -X POST http://localhost:5001/api/register \
  -F "name=Test User" \
  -F "email=test@test.com" \
  -F "employee_id=TEST123" \
  -F "image=@/path/to/your/face/photo.jpg" \
  -v  # verbose to see all details
```

## 📊 Registration Success Response

When successful, you'll get:
```json
{
  "message": "Employee registered successfully",
  "employee": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "employee_id": "EMP001",
    "created_at": "2026-02-05T17:10:30"
  }
}
```

## 🎯 Next Steps

1. ✅ Register employees with face photos
2. ✅ Use the Attendance Scanner to mark attendance
3. ✅ View attendance records and history
4. ✅ Generate attendance reports

---

**Status**: ✅ **READY TO USE**

The registration system is now fully functional. Upload a real face photo to register your first employee!
