import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
            print(selectedDate);
          },
          headerProps:  EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            monthStyle: TextStyle(color: Theme.of(context).canvasColor),
            selectedDateStyle: TextStyle(color: Theme.of(context).canvasColor),
            dateFormatter: DateFormatter.fullDateDMY(

            ),

          ),

          dayProps: const EasyDayProps(

            dayStructure: DayStructure.dayStrDayNum,

            activeDayStyle: DayStyle(
              dayNumStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.blueColor
              ),
              dayStrStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.blueColor
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: ColorsManager.whiteColor

                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Color(0xff3371FF),
                //     Color(0xff8426D6),
                //   ],
                // ),
              ),
            ),
            inactiveDayStyle: DayStyle(
              dayNumStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
              dayStrStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: ColorsManager.whiteColor

                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Color(0xff3371FF),
                //     Color(0xff8426D6),
                //   ],
                // ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const TaskItem(),
      ],
    );
  }
}