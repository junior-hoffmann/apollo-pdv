const mongoose = require("mongoose")

let product = new mongoose.Schema({
    code : {type: String, require: true},
    barCode : {type: String, require: true},
    description : {type: String, require: true},
    costPrice : {type: Number, require: true},
    salePrice : {type: Number, require: true},
    stock : {type: Number},
})

module.exports = mongoose.model("Product", product)