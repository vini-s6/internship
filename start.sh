#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Face Recognition Attendance System${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if backend dependencies are installed
echo -e "${YELLOW}Checking backend dependencies...${NC}"
cd "$SCRIPT_DIR/backend"
if ! python3 -c "import flask_sqlalchemy" 2>/dev/null; then
    echo -e "${YELLOW}Installing backend dependencies...${NC}"
    pip3 install -r requirements.txt
fi

# Initialize database if it doesn't exist
if [ ! -f "attendance.db" ]; then
    echo -e "${YELLOW}Initializing database...${NC}"
    python3 init_db.py
fi

# Check if frontend node_modules exist
echo -e "${YELLOW}Checking frontend dependencies...${NC}"
cd "$SCRIPT_DIR/frontend"
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}Installing frontend dependencies (this may take a few minutes)...${NC}"
    npm install
fi

# Start backend in background
echo -e "${GREEN}Starting Backend (Flask) on port 5001...${NC}"
cd "$SCRIPT_DIR/backend"
python3 app.py &
BACKEND_PID=$!
sleep 2

# Start frontend
echo -e "${GREEN}Starting Frontend (React) on port 3000...${NC}"
cd "$SCRIPT_DIR/frontend"
npm start &
FRONTEND_PID=$!

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ Both services are starting!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "Backend:  ${BLUE}http://localhost:5001${NC}"
echo -e "Frontend: ${BLUE}http://localhost:3000${NC}"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop all services${NC}"
echo ""

# Function to cleanup on exit
cleanup() {
    echo ""
    echo -e "${YELLOW}Stopping services...${NC}"
    kill $BACKEND_PID 2>/dev/null
    kill $FRONTEND_PID 2>/dev/null
    wait $BACKEND_PID 2>/dev/null
    wait $FRONTEND_PID 2>/dev/null
    echo -e "${GREEN}Services stopped${NC}"
    exit 0
}

# Set trap to cleanup on Ctrl+C
trap cleanup SIGINT

# Wait for both processes
wait $BACKEND_PID $FRONTEND_PID
