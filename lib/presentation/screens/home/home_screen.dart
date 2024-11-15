import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  List<Widget> tabs = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      const TasksTab(),
      const SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final appBarTitle = selectedIndex == 0
        ? localizations!.todo_List
        : localizations!.settings;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      extendBody: true,
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomAppBar(localizations),
      body: tabs[selectedIndex],
    );
  }

  Widget buildFab() => FloatingActionButton(
    onPressed: () async {
      await AddTaskBottomSheet.show(context);
    },
    child: const Icon(Icons.add),
  );

  Widget buildBottomAppBar(AppLocalizations localizations) => BottomAppBar(
    notchMargin: 8,
    child: BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          label: localizations.tasks,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: localizations.settings,
        ),
      ],
    ),
  );
}
