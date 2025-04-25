const express = require('express');
const profileController = require('../controllers/profileController');
const authController = require('../controllers/authController');
const router = express.Router();

// Get user profile
router.get('/profile', authController.verifyToken, profileController.getUserProfile);

// Update user profile
router.put('/profile', authController.verifyToken, profileController.updateUserProfile);

module.exports = router;
