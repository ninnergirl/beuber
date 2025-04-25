const messages = [];

exports.getMessages = (req, res) => {
  res.json(messages);
};

exports.sendMessage = (req, res) => {
  const { user, message, type } = req.body;
  const newMessage = { user, message, type, timestamp: new Date() };
  messages.push(newMessage);
  res.status(201).json(newMessage);
};
