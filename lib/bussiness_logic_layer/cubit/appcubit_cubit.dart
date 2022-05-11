import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_route_transition/page_route_transition.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_am/presentaion_layer/screens/add_task_screen.dart';
part 'appcubit_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppcubitInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  IconData icon = Icons.edit;

  void setIcon() {
    icon;
    emit(SetIconState());
  }

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(BottomNavIndexState());
  }

  Database? database;
  void createDataBase() {
    openDatabase('todo1.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE task(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,description TEXT,priority TEXT ,status TEXT)')
          .then((value) {});
    }, onOpen: (database) {
      selectFromDatabase(database);
    }).then((value) {
      database = value;
    });
    emit(DataBaseCreationState());
  }

  Future<void> insertIntoDatabase({
    required String title,
    required String date,
    required String time,
    String? priority,
    String? description,
  }) async {
    await database!.transaction((txn) {
      newTasks = [];
      return txn
          .rawInsert(
              'INSERT INTO task(title,date,time,description,priority,status) VALUES("$title","$date","$time","$description","$priority","New")')
          .then((value) {
        emit(InsertIntoDataBaseState());
        print(value);
        selectFromDatabase(database);
      }).catchError((e) {});
    });
  }

  void updateToDatebase(String status, int id) {
    database!.execute(
        'UPDATE task SET status =? WHERE id=?', [status, id]).then((value) {
      emit(UpdateTaskDataBaseState());
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];
      selectFromDatabase(database);
    });
  }

  void deleteFromDatabase(int id) {
    database!.execute('DELETE FROM task WHERE id =?', [id]);
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(DeleteFromDataBaseState());
    selectFromDatabase(database);
  }

  void selectFromDatabase(database) {
    database!.rawQuery("SELECT * FROM task").then((value) {
      value.forEach((element) {
        if (element["status"] == "New") {
          newTasks.add(element);
        } else if (element["status"] == "Done") {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(SelectFromDataBaseState());
    });
  }

  // add screen logic
  bool addScreen = false;

  final formKey = GlobalKey<FormState>();
  var isValid = false;

  void openAddScreen(BuildContext context) {
    if (addScreen) {
      icon = Icons.edit;
    } else {
      icon = Icons.close;
    }
    addScreen = !addScreen;

    emit(AddScreenState());
  }

  void createTask(formKey,
      {required TextEditingController dateController,
      required TextEditingController titleController,
      required TextEditingController timeController,
      TextEditingController? descriptionController}) {
    try {
      if (dateController.text.isNotEmpty &&
          titleController.text.isNotEmpty &&
          timeController.text.isNotEmpty) {
        insertIntoDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
                description: descriptionController?.text)
            .then((value) {
          print(descriptionController?.text);
          addScreen = false;
          icon = Icons.edit;
        });
      }
    } catch (e) {
      print(e.toString());
    }

    // emit(CreateFormState());
  }
}
