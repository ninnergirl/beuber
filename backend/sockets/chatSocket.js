let onlineUsers = {};

function chatSocket(io) {
  io.on('connection', (socket) => {
    console.log('Foydalanuvchi ulanmoqda:', socket.id);

    socket.on('userConnected', (userId) => {
      onlineUsers[userId] = socket.id;
      console.log('User online:', onlineUsers);
    });

    socket.on('sendMessage', ({ from, to, message }) => {
      const recipientSocket = onlineUsers[to];
      if (recipientSocket) {
        io.to(recipientSocket).emit('receiveMessage', { from, message });
      }
    });

    socket.on('disconnect', () => {
      for (let id in onlineUsers) {
        if (onlineUsers[id] === socket.id) {
          delete onlineUsers[id];
          break;
        }
      }
      console.log('Foydalanuvchi uzildi:', socket.id);
    });
  });
}

module.exports = chatSocket;
