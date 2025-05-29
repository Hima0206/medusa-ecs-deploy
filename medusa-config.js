const dotenv = require("dotenv");
dotenv.config();

module.exports = {
  apiKey: "your-api-key",
  environment: "production",
  services: [
    "service1",
    "service2"
  ]
};
  plugins: [
    medusa-fulfillment-manual,
    medusa-payment-manual
  ],
};
~         
