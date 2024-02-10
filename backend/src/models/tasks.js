const mongoose = require("mongoose")

let task = new mongoose.Schema({
    task: { type: String, require: true },
    date: { type: String, require: true },
    isFinished: { type: Boolean, require: true },
})

module.exports = mongoose.model("Task", task)