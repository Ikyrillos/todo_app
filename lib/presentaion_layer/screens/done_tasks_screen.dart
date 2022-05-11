import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_am/bussiness_logic_layer/cubit/appcubit_cubit.dart';
import 'package:todo_app_am/constants/theming.dart';
import 'package:todo_app_am/presentaion_layer/shared/components.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);
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
                    AppCubit.get(context).doneTasks[index],
                    context,
                    AppCubit.get(context).currentIndex,
                    cubit.doneTasks[index]['id'], (action) {
                  cubit.deleteFromDatabase(cubit.doneTasks[index]['id']);
                }),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: AppCubit.get(context).doneTasks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
