import 'package:flutter/material.dart';
import 'package:todo_app_am/bussiness_logic_layer/cubit/appcubit_cubit.dart';
import 'package:todo_app_am/constants/controllers.dart';
import 'package:todo_app_am/constants/routes.dart';
import 'package:todo_app_am/presentaion_layer/screens/task_details.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  // Function? onSubmit,
  void Function(String)? onChange,
  String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixPressed,
  onTap,
  // bool enabled = true,
  bool readOnly = false,
}) =>
    TextFormField(
      cursorRadius: const Radius.circular(10.0),
      // validator: (s) {
      //   validate(s);
      // },
      validator: validate,
      textInputAction: TextInputAction.next,
      readOnly: readOnly,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      // onFieldSubmitted: (S) {
      //   onSubmit!(S);
      // },

      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: () {
                  suffixPressed!();
                },
              )
            : null,
      ),
    );


Widget taskItem(Map item, BuildContext context, int index, int key,
    void Function(DismissDirection)? action) {
  var icons = [];
  var newScreenTaskIcons = [
    IconButton(
      onPressed: () {
        AppCubit.get(context).updateToDatebase("Done", item["id"]);
      },
      icon: const Icon(
        Icons.done_outline,
        color: Color(0xff649783),
      ),
    ),
    IconButton(
      onPressed: () {
        AppCubit.get(context).updateToDatebase("Archived", item["id"]);
      },
      icon: const Icon(
        Icons.archive,
        color: Color(0xff649783),
      ),
    ),
  ];
  var doneScreenTaskIcons = [
    IconButton(
      onPressed: () {
        AppCubit.get(context).updateToDatebase("New", item["id"]);
      },
      icon: const Icon(
        Icons.add_task,
        color: Color(0xff649783),
      ),
    ),
    IconButton(
      onPressed: () {
        AppCubit.get(context).updateToDatebase("Archived", item["id"]);
      },
      icon: const Icon(
        Icons.archive,
        color: Color(0xff649783),
      ),
    ),
  ];
  var archivedScreenTaskIcons = [
    IconButton(
      onPressed: () {
        AppCubit.get(context).updateToDatebase("New", item["id"]);
      },
      icon: const Icon(
        Icons.add_task,
        color: Color(0xff649783),
      ),
    ),
    IconButton(
      onPressed: () {
        AppCubit.get(context).updateToDatebase("Done", item["id"]);
      },
      icon: const Icon(
        Icons.done_outline,
        color: Color(0xff649783),
      ),
    ),
  ];

  if (titles[index] == 'New Tasks') {
    icons = newScreenTaskIcons;
  } else if (titles[index] == 'Done Tasks') {
    icons = doneScreenTaskIcons;
  } else {
    icons = archivedScreenTaskIcons;
  }
  return GestureDetector(
    onTap: () {
      navigateTo(
          context,
          TaskDetailsScreen(
            item: item,
          ));
    },
    child: Dismissible(
      key: Key('${item['id']}'),
      background: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ]),
          ),
        ),
      ),
      onDismissed: action,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            color: Color(0xffd1d7d7),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: const Color(0x00ffffff),
                child: Text(
                  item["time"],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff649783),
                  ),
                ),
                radius: 32,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    child: Text(
                      item["title"],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    item["date"],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [...icons],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
