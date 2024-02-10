const { json } = require('express')
const Sale = require('../models/sale')

module.exports = {

    async setNewSale(req, res) {
        try {
            let sale = new Sale(req.body)
            await sale.save()
            res.sendStatus(200)
        } catch (error) {
            console.log(error)
            res.send(false)
        }
    },

    async getAllSales(req, res) {
        try {
            let sales = await Sale.find({});
            res.send(sales)
        } catch (error) {
            res.send(error)
        }
    },

    async getFilteredSales(req, res) {
        try {
            let date = req.params.date
            let sales = await Sale.find({ "date": { $regex: '^' + date } })
            res.send(sales)
        } catch (error) {
            res.send(error)
        }
    }

}
