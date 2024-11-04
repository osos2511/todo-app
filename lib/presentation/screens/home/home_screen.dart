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
  GlobalKey<TasksTabState>tasksTabKey=GlobalKey();
  List<Widget> tabs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(key: tasksTabKey,),
      const SettingsTab(),
    ];
  }

  int selectedIndex = 0;
  String appBarMyApp='To Do List';
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
    onPressed: ()async {
     await AddTaskBottomSheet.show(context);
     tasksTabKey.currentState!.readTodosFromFireStore();
    },
    child: const Icon(Icons.add),
  );
  Widget buildBottomAppBar() => BottomAppBar(
    notchMargin: 8,
    child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            if(selectedIndex==0){
              appBarMyApp='To Do List';
            }else{
              appBarMyApp='Settings';
            }
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]),
  );

}
