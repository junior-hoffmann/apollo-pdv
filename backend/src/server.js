const app = require("./app")
const mongoose = require("mongoose")
const port = 9090;
mongoose.connect("mongodb://127.0.0.1:27017/apollopdv")

let db = mongoose.connection

app.listen(port, () =>
console.log(`Running on port ${port}`)
)

db.on("error", () => {console.log("----- Houve um erro -----")})
db.once("open", ()=>{
    console.log("Banco carregado")
})

