const Company = require('../models/company')

module.exports = {

    async getCompany(req, res) {
        try {
            let company = await Company.find({})
            res.send(company[0])
        } catch (error) {
            res.send(error)
        }
    },

    async setCompany(req, res) {
        try {
            let company = req.body
            let companyList = await Company.find({})
            if (companyList.length === 0) {
                let newCompany = new Company(req.body)
                await newCompany.save()
                res.sendStatus(200)
            } else {
                let id = companyList[0]['_id']
                await Company.updateOne({ _id: id }, company)
                res.sendStatus(200)
            }

        } catch (error) {
            res.send(error)
        }
    }

}