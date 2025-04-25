const axios = require('axios');

// Verify certificate function (example using a mock API)
exports.verifyCertificate = (req, res) => {
  const { certificateId, certificateType } = req.body;

  // Simulating an external API call for certificate verification
  axios.post('https://example.com/verify', { certificateId, certificateType })
    .then((response) => {
      if (response.data.isValid) {
        res.json({ success: true, message: 'Certificate is valid' });
      } else {
        res.status(400).json({ success: false, message: 'Invalid certificate' });
      }
    })
    .catch((err) => {
      res.status(500).json({ success: false, message: 'Server error' });
    });
};
