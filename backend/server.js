const express = require('express');
const cors = require('cors');
const http = require('http');
const fileUpload = require('express-fileupload');
const { Server } = require('socket.io');
const authRoutes = require('./routes/authRoutes');
require('./db');

const app = express();
const server = http.createServer(app);

// Middleware
app.use(cors());
app.use(express.json());
app.use(fileUpload());
app.use('/uploads', express.static('uploads')); // Uploaded fayllarni ko‘rsatish
app.use('/api/auth', authRoutes); // Auth marshrutlari

// SOCKET.IO SETUP
const io = new Server(server, {
  cors: {
    origin: '*',
    methods: ['GET', 'POST']
  }
});

// SOCKET.IO LOGIC
io.on('connection', (socket) => {
  console.log(`Foydalanuvchi ulanmoqda: ${socket.id}`);

  socket.on('join_room', (room) => {
    socket.join(room);
    console.log(`Socket ${socket.id} xonaga qo‘shildi: ${room}`);
  });

  socket.on('send_message', (data) => {
    console.log('Yangi xabar:', data);
    socket.to(data.room).emit('receive_message', data);
  });

  socket.on('disconnect', () => {
    console.log(`Foydalanuvchi uzildi: ${socket.id}`);
  });
});

// Fayl yuklash (rasm, video, docs)
app.post('/api/upload', (req, res) => {
  if (!req.files || !req.files.file) {
    return res.status(400).json({ error: 'Fayl topilmadi' });
  }

  const file = req.files.file;
  const filePath = `uploads/${Date.now()}_${file.name}`;

  file.mv(filePath, (err) => {
    if (err) {
      console.error(err);
      return res.status(500).send(err);
    }
    res.json({ path: `/${filePath}` });
  });
});

// SERVER PORT
const PORT = process.env.PORT || 5000;
server.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
