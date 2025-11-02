const mongoose = require('mongoose');
const { MongoClient } = require('mongodb')
mongoose.connect("mongodb://localhost:27017/Notogen", {
  
});

mongoose.connection.on('open', () => {
  console.log("✅ Notogen DB is Connected");
});

mongoose.connection.on('error', () => {
  console.log("❌ Notogen DB Not Connected");
});

module.exports = mongoose;
