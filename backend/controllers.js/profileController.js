const db = require('../db');

// Get user profile
exports.getUserProfile = (req, res) => {
  const userId = req.user.id; // From JWT token

  db.get('SELECT * FROM users WHERE id = ?', [userId], (err, row) => {
    if (err) return res.status(500).json({ success: false, message: 'Server error' });
    if (!row) return res.status(404).json({ success: false, message: 'User not found' });

    res.json({ success: true, profile: row });
  });
};

// Update user profile
exports.updateUserProfile = (req, res) => {
  const userId = req.user.id;
  const { name, phoneNumber } = req.body;

  db.run(
    'UPDATE users SET name = ?, phone_number = ? WHERE id = ?',
    [name, phoneNumber, userId],
    function (err) {
      if (err) return res.status(500).json({ success: false, message: 'Server error' });
      res.json({ success: true, message: 'Profile updated successfully' });
    }
  );
};
