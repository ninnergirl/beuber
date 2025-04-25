const db = require('../db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Register user
exports.registerUser = (req, res) => {
  const { email, password } = req.body;

  // Check if the user already exists
  db.get('SELECT * FROM users WHERE email = ?', [email], (err, row) => {
    if (err) return res.status(500).json({ success: false, message: 'Server error' });
    if (row) return res.status(400).json({ success: false, message: 'User already exists' });

    // Hash password
    bcrypt.hash(password, 10, (err, hashedPassword) => {
      if (err) return res.status(500).json({ success: false, message: 'Error hashing password' });

      // Save new user to DB
      db.run(
        'INSERT INTO users (email, password) VALUES (?, ?)',
        [email, hashedPassword],
        function (err) {
          if (err) return res.status(500).json({ success: false, message: 'Error registering user' });
          res.json({ success: true, message: 'User registered successfully' });
        }
      );
    });
  });
};

// Login user
exports.loginUser = (req, res) => {
  const { email, password } = req.body;

  // Check if user exists
  db.get('SELECT * FROM users WHERE email = ?', [email], (err, row) => {
    if (err) return res.status(500).json({ success: false, message: 'Server error' });
    if (!row) return res.status(400).json({ success: false, message: 'User not found' });

    // Compare password
    bcrypt.compare(password, row.password, (err, isMatch) => {
      if (err) return res.status(500).json({ success: false, message: 'Error comparing password' });
      if (!isMatch) return res.status(400).json({ success: false, message: 'Invalid credentials' });

      // Create JWT token
      const token = jwt.sign({ id: row.id, email: row.email }, 'secret_key', { expiresIn: '1h' });
      res.json({ success: true, token });
    });
  });
};

// Verify token middleware
exports.verifyToken = (req, res, next) => {
  const token = req.headers['authorization']?.split(' ')[1];

  if (!token) return res.status(403).json({ success: false, message: 'No token provided' });

  jwt.verify(token, 'secret_key', (err, decoded) => {
    if (err) return res.status(403).json({ success: false, message: 'Failed to authenticate token' });
    req.user = decoded;
    next();
  });
};
