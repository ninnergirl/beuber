const db = require('../db');
const jwt = require('jsonwebtoken');

const secretKey = 'your_jwt_secret_key'; // xavfsiz joyda saqlang

exports.registerUser = (req, res) => {
  const { email, password } = req.body;

  db.run(
    'INSERT INTO users (email, password) VALUES (?, ?)',
    [email, password],
    function (err) {
      if (err) return res.status(500).json({ success: false, message: 'Server error' });
      res.json({ success: true });
    }
  );
};

exports.loginUser = (req, res) => {
  const { email, password } = req.body;

  db.get(
    'SELECT * FROM users WHERE email = ? AND password = ?',
    [email, password],
    (err, row) => {
      if (err) return res.status(500).json({ success: false, message: 'Server error' });
      if (!row) return res.json({ success: false });

      const token = jwt.sign({ id: row.id }, secretKey, { expiresIn: '1h' });
      res.json({ success: true, token });
    }
  );
};
