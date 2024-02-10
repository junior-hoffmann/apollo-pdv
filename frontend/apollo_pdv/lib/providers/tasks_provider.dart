// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:apollo_pdv/models/task.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TasksProvider extends ChangeNotifier {
  final String server = "http://localhost:9090";

  final List<Task> _tasks = [];

  List<Task> get tasks => [..._tasks];

  Future<bool> setNewTask({required Task task}) async {
    String url = "$server/admin/tarefas/nova-tarefa";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: task.getJSON(),
      );
      if (response.statusCode == 200) {
        getTasks();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      // return "Ocorreu o seguinte erro: $e";
      return false;
    }
  }

  Future<void> getTasks() async {
    _tasks.clear();
    String url = "$server/admin/tarefas/todas-as-tarefas/";
    try {
      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);
      for (var item in data) {
        Task task =
            Task(task: item["task"], date: DateTime.parse((item["date"])));
        task.setId(id: item["_id"].toString());
        task.setIsFinished(isFinished: item["isFinished"]);
        _tasks.add(task);
      }
      _tasks.sort((a, b) => a.getDate().compareTo(b.getDate()));
    } catch (e) {
      print("Houve um erro: $e");
    }

    notifyListeners();
  }

  Future<String> setFinishTask({required String id}) async {
    String url = "$server/admin/tarefas/finalizar-tarefa";
    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "id": id,
          }));
      if (response.statusCode == 200) {
        await getTasks();
        notifyListeners();
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
