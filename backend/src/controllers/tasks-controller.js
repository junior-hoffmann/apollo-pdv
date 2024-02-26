const Task = require('../models/tasks')

module.exports = {

    async setNewTask(req, res) {
        try {
            let task = new Task(req.body)
            await task.save()
            res.sendStatus(200)
        } catch (error) {
            res.send(false)
        }
    },

    async setFinishTask(req, res) {
        try {
            let id = req.body["id"]
            await Task.findByIdAndDelete(id)
            res.sendStatus(200)
        } catch (error) {
            console.log(error)
            res.send(false)
        }
    },

    async getAllTasks(req, res) {
        try {
            let tasks = await Task.find({});
            res.send(tasks)
        } catch (error) {
            res.send(error)
        }
    }
}
