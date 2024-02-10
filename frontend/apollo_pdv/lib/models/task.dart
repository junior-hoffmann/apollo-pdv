import 'dart:convert';

import 'package:apollo_pdv/utils/formaters.dart';

class Task {
  late String _id;
  late String _task;
  late DateTime _date;
  bool _isFinished = false;

  Task({required String task, required DateTime date}) {
    _task = task;
    _date = date;
  }

  void setId({required String id}) => _id = id;
  void setIsFinished({required bool isFinished}) => _isFinished = isFinished;
  DateTime getDate() => _date;

  bool getIsFinished() => _isFinished;

  Map<String, dynamic> getTask() => {
        "id": _id,
        "task": _task,
        "date": Formatters().formatDate(date: _date),
        "isFinished": _isFinished,
        "warning": getWarning(),
      };

  String getJSON() {
    return json.encode({
      "task": _task,
      "date": _date.toIso8601String(),
      "isFinished": _isFinished,
    });
  }

  bool getWarning() {
    DateTime today = DateTime.now();
    return _date.day == today.day &&
        _date.month == today.month &&
        _date.year == today.year || today.isAfter(_date);
  }
}
