const fileUpload = require('express-fileupload');
const path = require('path');

// Handle file uploads
exports.uploadFile = (req, res) => {
  if (!req.files || !req.files.file) {
    return res.status(400).json({ error: 'No file uploaded' });
  }

  const file = req.files.file;
  const uploadPath = path.join(__dirname, '../uploads', Date.now() + path.extname(file.name));

  file.mv(uploadPath, (err) => {
    if (err) {
      console.error('Upload error:', err);
      return res.status(500).json({ error: 'Error uploading file' });
    }
    res.json({ success: true, filePath: uploadPath });
  });
};
