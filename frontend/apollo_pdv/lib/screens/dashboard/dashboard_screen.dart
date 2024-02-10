// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/product.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/models/task.dart';
import 'package:apollo_pdv/providers/products_provider.dart';
import 'package:apollo_pdv/providers/sales_provider.dart';
import 'package:apollo_pdv/providers/tasks_provider.dart';
import 'package:apollo_pdv/screens/dashboard/tabs/products_tab.dart';
import 'package:apollo_pdv/screens/dashboard/tabs/sales_tab.dart';
import 'package:apollo_pdv/screens/dashboard/tabs/start_tab.dart';
import 'package:apollo_pdv/screens/dashboard/tabs/tasks_tab.dart';
import 'package:apollo_pdv/screens/widgets/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});
  List<Product> products = [];
  List<Sale> sales = [];
  List<Task> tasks = [];
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);

      productsProvider.getProducts();

      final salesProvider = Provider.of<SalesProvider>(context, listen: false);

      salesProvider.getSales();

      final tasksProvider = Provider.of<TasksProvider>(context, listen: false);

      tasksProvider.getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductsProvider>(context, listen: true);

    widget.products.clear();
    widget.sales.clear();
    widget.tasks.clear();

    widget.products =
        Provider.of<ProductsProvider>(context, listen: true).products;

    widget.sales = Provider.of<SalesProvider>(context, listen: true).sales;

    widget.tasks = Provider.of<TasksProvider>(context, listen: true).tasks;

    final List<Widget> tabs = [
      StartTab(
        tasks: widget.tasks,
      ),
      ProductsTab(products: widget.products),
      SalesTab(sales: widget.sales),
      TasksTab(tasks: widget.tasks),
    ];
    return Scaffold(
      backgroundColor: Colors.white ,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Image.asset("images/logo/logo_apollo_pdv.png"),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NavigationButton(
                        isSelected: _tabIndex == 0 ? true : false,
                        size:
                            (MediaQuery.of(context).size.width * 0.75) / 6 - 20,
                        title: "Início",
                        urlImage: "images/icons/painel-de-controle.png",
                        onTap: () {
                          setState(() {
                            _tabIndex = 0;
                          });
                        },
                      ),
                      NavigationButton(
                        isSelected: _tabIndex == 1 ? true : false,
                        size:
                            (MediaQuery.of(context).size.width * 0.75) / 6 - 20,
                        title: "Produtos",
                        urlImage: "images/icons/caixa.png",
                        onTap: () {
                          setState(() {
                            _tabIndex = 1;
                          });
                        },
                      ),
                      NavigationButton(
                        isSelected: _tabIndex == 2 ? true : false,
                        size:
                            (MediaQuery.of(context).size.width * 0.75) / 6 - 20,
                        title: "Vendas",
                        urlImage: "images/icons/caixa-eletronico.png",
                        onTap: () {
                          setState(() {
                            _tabIndex = 2;
                          });
                        },
                      ),
                      NavigationButton(
                        isSelected: _tabIndex == 3 ? true : false,
                        size:
                            (MediaQuery.of(context).size.width * 0.75) / 6 - 20,
                        title: "Tarefas",
                        urlImage: "images/icons/exame.png",
                        onTap: () {
                          setState(() {
                            _tabIndex = 3;
                          });
                        },
                      ),
                      NavigationButton(
                        isSelected: false,
                        size:
                            (MediaQuery.of(context).size.width * 0.75) / 6 - 20,
                        title: "Ajustes",
                        urlImage: "images/icons/definicoes.png",
                        onTap: () {},
                      ),
                      NavigationButton(
                        isSelected: false,
                        size:
                            (MediaQuery.of(context).size.width * 0.75) / 6 - 20,
                        title: "Ajuda",
                        urlImage: "images/icons/ajudando.png",
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          tabs[_tabIndex],
        ],
      ),
    );
  }
}
