// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/task.dart';
import 'package:apollo_pdv/providers/tasks_provider.dart';
import 'package:apollo_pdv/screens/widgets/postit_card.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/screens/widgets/title_row.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksTab extends StatefulWidget {
  List<Task> tasks;

  TasksTab({required this.tasks, Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  final AppTheme _theme = AppTheme();
  late List<Task> tasksFiltered;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  const TitleRow(
                    title: "Tarefas",
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
                    child: newTask(context: context),
                  ),
                ],
              ),
            ),
            widget.tasks.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Padding(
                           padding: const EdgeInsets.only(top: 40),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.width * 0.15,
                            child: Image.asset("images/icons/pasta-vazia.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            "Você está sem lembretes",
                            style: TextStyle(
                                color: _theme.primaryColor,
                                fontSize: MediaQuery.of(context).size.width * 0.03),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    bottom: 8,
                    top: 8,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: widget.tasks.length,
                    itemBuilder: (BuildContext context, int index) =>
                        PostitCard(task: widget.tasks[index]),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget newTask({required BuildContext context}) {
    TextEditingController taskController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    DateTime date = DateTime.now();

    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              labelText: "O que você quer se lembrar?",
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SizedBox(
            width: (MediaQuery.of(context).size.width - 96) / 5,
            child: InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((value) {
                  try {
                    date = value!;
                    dateController.text =
                        Formatters().formatSimpleDate(date: value);
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(Warnings().snackBar(
                      value: "Erro ao selecionar uma data!",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    ));
                  }
                });
              },
              child: TextField(
                enabled: false,
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: "Data",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false).setNewTask(
                    task: Task(task: taskController.text, date: date));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _theme.primaryColor,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(_theme.borderRadius)),
              ),
              child: const Text("Salvar"),
            ),
          ),
        ),
      ],
    );
  }
}
