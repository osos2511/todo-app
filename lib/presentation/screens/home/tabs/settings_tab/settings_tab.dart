import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/provider/theme_provider.dart';
class SettingsTab extends StatefulWidget {
   const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String? selectedTheme='Light';
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme',style: Theme.of(context).textTheme.labelSmall,),
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedTheme??'',style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: ColorsManager.blueColor,
                      fontSize: 16
                  ),),
                  DropdownButton<String>(
                    underline: const SizedBox.shrink(),
                    dropdownColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    isExpanded: false,
                    style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),
                    items: <String>['Light','Dark'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newTheme) {
                     context.read<ThemeProvider>().changeAppTheme(newTheme=='Light'?ThemeMode.light:ThemeMode.dark);

                    },
                  )

                ],
              ),
            ),
          ],
      ),
    );
  }
}
