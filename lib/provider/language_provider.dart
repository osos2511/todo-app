import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//step 1
class LanguageProvider extends ChangeNotifier {
  String currentLang = 'en';

  void changeAppLang(String newLang) {
    if (currentLang == newLang) return;
    currentLang = newLang;
    saveLang(newLang); //step two->shared preferences
    notifyListeners();
  }

  bool isSelectedEnglish() {
    return currentLang == 'en';
  }



  //1-step one ->shared preferences
  void saveLang(String language) async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance(); //take reference only
    if (language == 'en') {
      prefs.setString('language', 'en');
    } else {
      prefs.setString('language', 'ar');
    }
  }

//3-step three->shared preferences
  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString('language') ?? '';
    if (theme == 'en') {
      currentLang = 'en';
    } else {
      currentLang = 'ar';
    }
    notifyListeners();
  }
}
