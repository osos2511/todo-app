import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/date_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddTaskBottomSheet(),
      ),
    );
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime userSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).indicatorColor,
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add New Task',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter your task',
                hintStyle: Theme.of(context).textTheme.displayMedium),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your Description',
              hintStyle: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Select Date',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).canvasColor,
                ),
          ),
          InkWell(
              onTap: () {
                showTaskDatePicker();
              },
              child: Text(
                userSelectedDate.dateFormatted(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              )),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }

  void showTaskDatePicker() async {
    userSelectedDate = await showDatePicker(
          //selectableDayPredicate: (day)=>day.day!=20,=>this day is holiday
          //barrierDismissible: false,
          context: context,

          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        ) ??
        userSelectedDate;
    setState(() {});

  }
}
