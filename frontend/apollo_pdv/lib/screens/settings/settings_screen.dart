// ignore_for_file: must_be_immutable
import 'package:apollo_pdv/models/company.dart';
import 'package:apollo_pdv/providers/company_provider.dart';
import 'package:apollo_pdv/screens/widgets/input.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  Company company;

  SettingsScreen({super.key, required this.company});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppTheme _theme = AppTheme();

  @override
  void initState() {
    super.initState();
   if(_hasData()){
     widget.nameController.text = widget.company.getName().toString();
    widget.streetController.text =
        widget.company.getAddress()["street"].toString();
    widget.numberController.text =
        widget.company.getAddress()["number"].toString();
    widget.neighborhoodController.text =
        widget.company.getAddress()["neighborhood"].toString();
    widget.cityController.text = widget.company.getAddress()["city"].toString();
    widget.ufController.text = widget.company.getAddress()["uf"].toString();
    widget.cnpjController.text = widget.company.getCNPJ().toString();
    widget.phoneController.text = widget.company.getPhone().toString();
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 40,
          child: Image.asset(
            "images/logo/logo_apollo_pdv.png",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 40),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(
                "Ajustes",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Input(
                      placeholder: "Nome da loja",
                      controller: widget.nameController,
                      context: context,
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Input(
                      placeholder: "Telefone",
                      controller: widget.phoneController,
                      context: context,
                      isNumber: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Input(
                      placeholder: "CNPJ",
                      controller: widget.cnpjController,
                      context: context,
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            const Text("Endereço"),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Input(
                      placeholder: "Rua",
                      controller: widget.streetController,
                      context: context,
                      isNumber: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Input(
                      placeholder: "Número",
                      controller: widget.numberController,
                      context: context,
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Input(
                    placeholder: "Bairro",
                    controller: widget.neighborhoodController,
                    context: context,
                    isNumber: false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Input(
                    placeholder: "Cidade",
                    controller: widget.cityController,
                    context: context,
                    isNumber: false,
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 50,
                  child: Input(
                    placeholder: "UF",
                    controller: widget.ufController,
                    context: context,
                    isNumber: false,
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _theme.primaryColor,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(_theme.borderRadius)),
                ),
                onPressed: () {
                  try {
                    if (_controllersIsEmpty()) {
                      Provider.of<CompanyProvider>(context, listen: false)
                          .setCompany(
                              company: Company(
                        name: widget.nameController.text,
                        address: {
                          "street": widget.streetController.text,
                          "number": widget.numberController.text,
                          "neighborhood": widget.neighborhoodController.text,
                          "city": widget.cityController.text,
                          "uf": widget.ufController.text,
                        },
                        cnpj: widget.cnpjController.text,
                        phone: widget.phoneController.text,
                      ))
                          .then((value) {
                        if (value) {
                          Navigator.pop(context, true);
                        }
                      });
                    } else {
                      throw Error();
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      Warnings().snackBar(
                          value: "Preencha todos os campos!",
                          backgroundColor: Colors.red,
                          textColor: Colors.white),
                    );
                  }
                },
                child: const Text(
                  "Salvar dados da loja",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasData(){
    return widget.company.getName().isNotEmpty && 
    widget.company.getAddress().isNotEmpty &&
    widget.company.getPhone().isNotEmpty &&
    widget.company.getCNPJ().isNotEmpty;
  }

  bool _controllersIsEmpty() {
    return widget.nameController.text.isNotEmpty &&
        widget.streetController.text.isNotEmpty &&
        widget.numberController.text.isNotEmpty &&
        widget.neighborhoodController.text.isNotEmpty &&
        widget.cityController.text.isNotEmpty &&
        widget.ufController.text.isNotEmpty &&
        widget.cnpjController.text.isNotEmpty &&
        widget.phoneController.text.isNotEmpty;
  }
}
