import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).indicatorColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children:  [
            SlidableAction(
              onPressed: (context) {
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children:  [
            SlidableAction(
              onPressed: (context) {
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 3,
                  height: 65,
                  color: Theme.of(context).dividerColor,
                ),
                const SizedBox(width: 25,),
                Column(
                  children: [
                    Text('Task Title',style:  Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       Icon(Icons.lock_clock,color: Theme.of(context).iconTheme.color,),
                      Text('10:30 AM',style: Theme.of(context).textTheme.titleSmall),
        
                    ],),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.check,color: Colors.white,size: 35,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
