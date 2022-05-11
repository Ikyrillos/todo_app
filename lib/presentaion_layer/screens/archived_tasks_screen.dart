import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_am/bussiness_logic_layer/cubit/appcubit_cubit.dart';
import 'package:todo_app_am/constants/routes.dart';
import 'package:todo_app_am/constants/theming.dart';
import 'package:todo_app_am/presentaion_layer/shared/components.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Container(
        width: double.infinity,
        padding: screensPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => taskItem(
                    AppCubit.get(context).archivedTasks[index],
                    context,
                    AppCubit.get(context).currentIndex,
                    cubit.archivedTasks[index]['id'], (action) {
                  cubit.deleteFromDatabase(cubit.archivedTasks[index]['id']);
                }),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: AppCubit.get(context).archivedTasks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
