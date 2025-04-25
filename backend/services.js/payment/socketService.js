const { Server } = require('socket.io');

// Initialize socket.io
exports.initializeSocket = (server) => {
  const io = new Server(server, {
    cors: {
      origin: '*',
      methods: ['GET', 'POST']
    }
  });

  io.on('connection', (socket) => {
    console.log('New user connected: ' + socket.id);

    // Join room
    socket.on('joinRoom', (room) => {
      socket.join(room);
      console.log(`Socket ${socket.id} joined room: ${room}`);
    });

    // Send message
    socket.on('sendMessage', (data) => {
      io.to(data.room).emit('receiveMessage', data);
    });

    // Disconnect
    socket.on('disconnect', () => {
      console.log('User disconnected: ' + socket.id);
    });
  });

  return io;
};
