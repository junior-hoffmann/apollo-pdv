const mongoose = require('mongoose')

let company = new mongoose.Schema({
    name: { type: String, require: true },
    address: { type: Object, require: true },
    cnpj: { type: String, require: true },
    phone: { type: String, require: true },
})

module.exports = mongoose.model('Company', company)