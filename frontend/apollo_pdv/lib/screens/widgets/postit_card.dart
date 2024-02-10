// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/task.dart';
import 'package:apollo_pdv/providers/tasks_provider.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostitCard extends StatelessWidget {
  late Task task;

  PostitCard({
    super.key,
    required this.task,
  });

  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: task.getWarning() ? _theme.postitRed : _theme.postitYellow,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      task.getTask()["task"],
                      softWrap: true,
                      style: TextStyle(
                        color: task.getWarning() ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform.translate(
                offset: const Offset(10, -16),
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: InkWell(
                    onTap: () {
                      Provider.of<TasksProvider>(context, listen: false)
                          .setFinishTask(id: task.getTask()["id"])
                          .then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              Warnings().snackBar(
                                  value: "Lembrete concluído",
                                  backgroundColor: Colors.lightGreen,
                                  textColor: Colors.white),
                            ),
                          );
                    },
                    child: const Card(
                      color: Color.fromARGB(255, 255, 83, 84),
                      child: Center(
                        child: Text(
                          "X",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
