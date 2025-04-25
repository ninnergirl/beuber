exports.handlePaymePayment = async (req, res) => {
  const { amount, orderId } = req.body;

  try {
    console.log('Payme payment started:', { amount, orderId });

    // Payme logikasi (token, API ulanishi) bu yerga yoziladi
    return res.status(200).json({ success: true, message: 'Payme payment successful' });
  } catch (err) {
    return res.status(500).json({ success: false, message: 'Payme payment failed', error: err.message });
  }
};
 