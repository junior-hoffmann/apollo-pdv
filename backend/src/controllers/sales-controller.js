const { json } = require('express')
const Sale = require('../models/sale')
const Product = require("../models/product")


async function reduceStock(barCode, amount) {
    await Product.findOneAndUpdate({ barCode: barCode }, { $inc: { stock: -amount } })
}

module.exports = {

    async setNewSale(req, res) {
        try {
            let sale = new Sale(req.body)
            await sale.save()
            let products = req.body["products"]
            await products.forEach(p => {
                reduceStock(p["barCode"], p["amount"])
            });

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
            if (req.params.lastdate !== undefined) {
                let firstdate = req.params.firstdate
                let lastdate = req.params.lastdate
                let sales = await Sale.find({
                    "date": {
                        $gte: firstdate,
                        $lte: lastdate
                    }
                });
                res.send(sales)
            } else {
                let date = req.params.firstdate
                let sales = await Sale.find({ "date": { $regex: '^' + date } })
                res.send(sales)
            }
        } catch (error) {
            res.send(error)
        }
    }

}
