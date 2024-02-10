const mongoose = require("mongoose")

let sale = new mongoose.Schema({
    date: { type: String, require: true },
    paymentForm: { type: Object, require: true },
    serialCode: { type: Number, require: true },
    discount: { type: Number, require: true },
    products: { type: Object, require: true }
})

module.exports = mongoose.model("Sale", sale)