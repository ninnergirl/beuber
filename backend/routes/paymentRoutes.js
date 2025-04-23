const express = require('express');
const router = express.Router();

const stripeService = require('../services.js/payment/stripe_service');
const paymeService = require('../services.js/payment/payme_service');

// STRIPE
router.post('/stripe/pay', stripeService.handleStripePayment);

// PAYME
router.post('/payme/pay', paymeService.handlePaymePayment);

module.exports = router;
