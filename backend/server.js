const express = require('express');
const cors = require('cors');
const fileUpload = require('express-fileupload');
const { initializeSocket } = require('./services/socketService');
const authRoutes = require('./routes/authRoutes');
const profileRoutes = require('./routes/profileRoutes');
const lessonRoutes = require('./routes/lessonRoutes');
const uploadService = require('./services/uploadService');
const certificateService = require('./services/certificateService');
const db = require('./db'); // Import DB

const app = express();
const server = require('http').createServer(app);

// Middleware
app.use(cors());
app.use(express.json());
app.use(fileUpload());
app.use('/uploads', express.static('uploads'));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/profile', profileRoutes);
app.use('/api/lessons', lessonRoutes);

// File upload route
app.post('/api/upload', uploadService.uploadFile);

// Certificate verification route
app.post('/api/verify-certificate', certificateService.verifyCertificate);

// Initialize WebSocket
const io = initializeSocket(server);

// Server running
const PORT = process.env.PORT || 5000;
server.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
