const jwt = require('jsonwebtoken');
const secretKey = 'your_jwt_secret_key';

function verifyToken(req, res, next) {
  const token = req.headers['authorization'];

  if (!token) return res.status(403).json({ message: 'Token required' });

  jwt.verify(token, secretKey, (err, decoded) => {
    if (err) return res.status(401).json({ message: 'Invalid token' });

    req.user = decoded;
    next();
  });
}

module.exports = verifyToken;

