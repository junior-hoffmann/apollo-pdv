const express = require("express")
const routes = express.Router()

const productsController = require("../controllers/products-controller")
const salesController = require("../controllers/sales-controller")
const tasksController = require("../controllers/tasks-controller")

// PRODUTOS
routes.get("/produtos/todos-os-produtos/", productsController.getAllProducts)
routes.get("/produtos/pesquisa/:id", productsController.getProduct)
routes.post("/admin/produtos/novo-produto", productsController.setNewProduct)
routes.post("/admin/produtos/editar/:id", productsController.editProduct)
routes.post("/admin/produtos/set-estoque/", productsController.setStock)
routes.post("/admin/produtos/reduzir-estoque/:cod", productsController.reduceStock)
routes.delete("/admin/produtos/excluir-produto/:id", productsController.deleteProduct)

// VENDAS
routes.post("/admin/vendas/nova-venda", salesController.setNewSale)
routes.get("/admin/vendas/todas-as-vendas/", salesController.getAllSales)
routes.get("/admin/vendas/vendas-filtradas/:date", salesController.getFilteredSales)

// TAREFAS
routes.post("/admin/tarefas/nova-tarefa", tasksController.setNewTask)
routes.get("/admin/tarefas/todas-as-tarefas/", tasksController.getAllTasks)
routes.post("/admin/tarefas/finalizar-tarefa", tasksController.setFinishTask)


module.exports = routes