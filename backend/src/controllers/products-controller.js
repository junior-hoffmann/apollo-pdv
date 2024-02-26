const Product = require("../models/product")


module.exports = {

    async getAllProducts(req, res) {
        try {
            let products = await Product.find({});
            res.send(products)
        } catch (error) {
            res.send(error)
        }
    },

    async getProduct(req, res) {
        let id = req.params.id
        try {
            let product = await Product.findById(id)
            res.send(product)
        } catch (error) {
            console.log(error)
        }
    },

    async setNewProduct(req, res) {
        let product = new Product(req.body)
        try {
            await product.save()
            res.send("Produto cadastrado com sucesso!")
        } catch (error) {
            console.log(error)
        }
    },

    async editProduct(req, res) {
        let id = req.params.id
        let product = req.body
        if (!id) {
            res.send("Não tem _ID")
        }
        try {
            let productEdited = await Product.updateOne({ _id: id }, product)
            res.send("Produto editado com sucesso!")
        } catch (error) {
            res.send(error)
        }
    },

    async deleteProduct(req, res) {
        let id = req.params.id
        try {
            await Product.findByIdAndDelete(id)
            res.send("Produto exluído com sucesso!")
        } catch (error) {
            res.send(error)
        }
    },

    async setStock(req, res) {
        let productCode = req.body["barCode"]
        let amount = req.body["amount"]
        if (!productCode) {
            return res.send("Não foi possível realizar a operção pois falta o código do produto!")
        }
        if (amount <= 0) {
            amount = 0;
        }

        if (amount > 0) {
            try {
                let product = await Product.findOne({ barCode: productCode })
                await Product.findByIdAndUpdate({ _id: product._id }, { $inc: { stock: amount } })
                return res.send("Estoque alterado com sucesso!")
            } catch (error) {
                return res.send(error)
            }
        } else {
            return res.send("Não foi possível realizar a operação. Digite um valor maior que zero!")
        }
    },

    async reduceStock(req, res) {
        let productCode = req.params.cod
        let amount = req.body[0].amount
        if (!productCode) {
            res.send("Não foi possível realizar a operção pois falta o código do produto!")
        }
        if (amount <= 0) {
            amount = 0;
        }

        if (amount > 0) {
            try {
                let product = await Product.findOne({ cod: productCode })
                await Product.findByIdAndUpdate({ _id: product._id }, { $inc: { stock: -amount } })
                res.send("Estoque alterado com sucesso!")
            } catch (error) {
                res.send(error)
            }
        } else {
            res.send("Houve um erro desconhecido!")
        }
    },
}