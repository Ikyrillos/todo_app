import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_am/bussiness_logic_layer/cubit/appcubit_cubit.dart';
import 'package:todo_app_am/constants/routes.dart';
import 'package:todo_app_am/constants/theming.dart';
import 'package:todo_app_am/presentaion_layer/screens/add_task_screen.dart';
import 'package:todo_app_am/presentaion_layer/shared/components.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  bool isBottomSheetOpen = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          var currentScreen = screens[cubit.currentIndex];
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: const Color(0xff769783),
              title: Text(
                titles[cubit.currentIndex],
                style: appBarTitle,
              ),
              centerTitle: true,
            ),
            //cubit.addScreen ? AddTasKScreen() :
            body: cubit.addScreen ? AddTasKScreen() : currentScreen,
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff649783),
              onPressed: () {
                cubit.openAddScreen(context);
              },
              child: Icon(cubit.icon),
            ),
            bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: const Color(0xff649783),
                type: BottomNavigationBarType.fixed,
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (index) {
                  AppCubit.get(context).changeCurrentIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done_rounded), label: 'Done Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Archive'),
                ]),
          );
        },
      ),
    );
  }
}
