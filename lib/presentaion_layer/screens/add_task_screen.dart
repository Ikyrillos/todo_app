import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_am/bussiness_logic_layer/cubit/appcubit_cubit.dart';
import 'package:todo_app_am/constants/theming.dart';
import 'package:todo_app_am/presentaion_layer/shared/components.dart';

// ignore: must_be_immutable
class AddTasKScreen extends StatelessWidget {
  AddTasKScreen({Key? key}) : super(key: key);
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables

  @override
  Widget build(BuildContext context) {
    // switch (priority) {
    //   case 'Important':
    //     priority = const Color(0xff99CC00);
    //     break;
    //   case 'Do later':
    //     priority = const Color(0xff36A4DD);
    //     break;
    //   case 'Delay':
    //     priority = const Color(0xffFF9F00);
    //     break;
    //   case 'Avoid':
    //     priority = const Color(0xffFF4D4E);
    //     break;
    //   default:
    // }
    var cubit = AppCubit.get(context);
    return Material(
      
      child: Container(
        color: Colors.white,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: Text(
                    'Add new task',
                    style: appBarTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title field is required';
                        }
                        return null;
                      },
                      controller: titleController,
                      type: TextInputType.text,
                      label: 'Title',
                      prefix: Icons.file_copy),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date field is required';
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: dateController,
                    type: TextInputType.number,
                    label: 'Date',
                    prefix: Icons.calendar_today,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2022-12-01'),
                      ).then((value) {
                        dateController.text = DateFormat.yMMMd().format(value!);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Time field is required';
                        }
                        return null;
                      },
                      readOnly: true,
                      controller: timeController,
                      type: TextInputType.number,
                      label: 'Time',
                      prefix: Icons.punch_clock_outlined,
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          timeController.text = value!.format(context);
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                      controller: descriptionController,
                      type: TextInputType.text,
                      label: 'Description',
                      prefix: Icons.text_fields),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                    cubit.createTask(formKey,
                        dateController: dateController,
                        timeController: timeController,
                        titleController: titleController,
                        descriptionController: descriptionController);
                  },
                  child: const Text('Add task'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff769783),
                    fixedSize: const Size(130, 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
