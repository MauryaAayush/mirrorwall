import 'dart:developer';

import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier
{
  double progress = 0;
  String searchtext = 'Google';

  List <String> bookmarkList= [];
  String? currentUrl;
  List <String> historylist = [];
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
    log('link url----------------------------------------------');
    currentUrl = Url;
    notifyListeners();
  }

  void addtoBookMark()
  {
    log('link asd----------------------------------------------');
    bookmarkList.add(currentUrl!);
    notifyListeners();
  }

  void seturlforhistory(String url)
  {
    log('link assigned----------------------------------------------');

    searchvalue = url;

    notifyListeners();
  }

  void addtoHistory()
  {
    historylist.add(searchvalue!);
    log('link added------------------------------------------------');
    notifyListeners();
  }
}