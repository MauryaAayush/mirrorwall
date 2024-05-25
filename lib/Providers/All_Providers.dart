import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier
{
  double progress = 0;
  String searchtext = 'Google';

  void onchange_progress(int progress)
  {
    this.progress = progress/100;
    notifyListeners();
  }

  void search(String searchtext)
  {
    this.searchtext = searchtext;
    notifyListeners();
  }
}