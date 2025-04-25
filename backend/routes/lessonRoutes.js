const express = require('express');
const lessonController = require('../controllers/lessonController');
const authController = require('../controllers/authController');
const router = express.Router();

// Create lesson route
router.post('/lesson', authController.verifyToken, lessonController.createLesson);

// Get user lessons route
router.get('/lessons', authController.verifyToken, lessonController.getUserLessons);

module.exports = router;
