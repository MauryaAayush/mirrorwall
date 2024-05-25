import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier
{
  double progress = 0;
  String searchtext = 'Google';

  List <String> bookmarkList= [];
  String? currentUrl;
  List <String> history = [];
  String? searchvalue;

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

  void setcurrentUrl(String Url)
  {
    currentUrl = Url;
    notifyListeners();
  }

  void addtoBookMark()
  {
    bookmarkList.add(currentUrl!);
    notifyListeners();
  }

  void seturlforhistory(String url)
  {
    searchvalue = url;
    notifyListeners();
  }

  void addtoHistory()
  {
    history.add(searchvalue!);
    notifyListeners();
  }
}