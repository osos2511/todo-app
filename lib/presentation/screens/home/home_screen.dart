import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    const TasksTab(),
    const SettingsTab(),
  ];

  int selectedIndex = 0;
  String appBarMyApp='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(appBarMyApp),
      ),
      extendBody: true,
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomAppBar(),
      body: tabs[selectedIndex],
    );
  }
  Widget buildFab() => FloatingActionButton(
    onPressed: () {
      AddTaskBottomSheet.show(context);
    },
    child: const Icon(Icons.add),
  );
  Widget buildBottomAppBar() => BottomAppBar(
    notchMargin: 8,
    child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          if(selectedIndex==0){
            appBarMyApp='To Do List';
          }else{
            appBarMyApp='Settings';
          }
          setState(() {});

        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]),
  );

}
