const db = require('../db');

// Create a new lesson
exports.createLesson = (req, res) => {
  const { title, description, date, userId } = req.body;

  db.run(
    'INSERT INTO lessons (title, description, date, user_id) VALUES (?, ?, ?, ?)',
    [title, description, date, userId],
    function (err) {
      if (err) return res.status(500).json({ success: false, message: 'Error creating lesson' });
      res.json({ success: true, message: 'Lesson created successfully', lessonId: this.lastID });
    }
  );
};

// Get lessons for a user
exports.getUserLessons = (req, res) => {
  const userId = req.user.id;

  db.all('SELECT * FROM lessons WHERE user_id = ?', [userId], (err, rows) => {
    if (err) return res.status(500).json({ success: false, message: 'Error fetching lessons' });
    res.json({ success: true, lessons: rows });
  });
};
