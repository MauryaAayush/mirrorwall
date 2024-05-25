import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:untitled/Utils/Global_Variables.dart';

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

  Future<void> setcurrentUrl()
  async {

    WebUri? webUri = await inAppWebViewController.getUrl();
    currentUrl = await inAppWebViewController.getTitle() as String;
    notifyListeners();



  }

  void addtoBookMark()
  {
    log('link asd----------------------------------------------');
    bookmarkList.add(currentUrl!);
    notifyListeners();
  }


  void addtoHistory()
  {
    historylist.add(currentUrl!);
    log('link added------------------------------------------------');
    notifyListeners();
  }
}