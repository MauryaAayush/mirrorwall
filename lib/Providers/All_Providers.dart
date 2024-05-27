import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:untitled/Utils/Global_Variables.dart';

class MainProvider extends ChangeNotifier {
  double progress = 0;

  String searchtext = 'Google';
  String newsearchtext = '';
  String groupValue = 'Google';
  String? currentUrl;

  bool isButtonEnabled = true;
  bool isButtonForward = false;

  List searchEngineNames = ['Google', 'Bing', 'Duck Duck Go', 'Yahoo'];
  List<String> bookmarkList = [];
  List<String> historylist = [];


// for progress indicator
  Future<void> onchange_progress(int progress) async {
    this.progress = progress / 100;
    notifyListeners();
  }

  Future<void> goBack() async {
    await inAppWebViewController.goBack();
    notifyListeners();
  }

  Future<void> canGoBack()
  async {
    // checkIfShouldGoBack();
    isButtonEnabled = await inAppWebViewController.canGoBack();
    notifyListeners();
  }

  Future<void> goForward()
  async {
    await inAppWebViewController.goForward();
    notifyListeners();
  }

  Future<void> canGoForward()
  async {
    isButtonForward = await inAppWebViewController.canGoForward();
    notifyListeners();
  }

  void search(String searchtext) {
    this.searchtext = searchtext;
    notifyListeners();
  }

  Future<void> setcurrentUrl() async {
    // WebUri? webUri = await inAppWebViewController.getUrl();
    currentUrl = await inAppWebViewController.getTitle() as String;
    notifyListeners();
  }

  void addtoBookMark() {
    bookmarkList.add(currentUrl!);
    notifyListeners();
  }

  void addtoHistory() {
    historylist.add(currentUrl!);
    notifyListeners();
  }

  void updateSearchEngine(String value) {
    searchtext = value;
    if (searchtext == 'Google') {
      inAppWebViewController.loadUrl(
          urlRequest: URLRequest(url: WebUri("https://www.google.com/")));
    } else if (searchtext == 'Yahoo') {
      inAppWebViewController.loadUrl(
          urlRequest: URLRequest(url: WebUri("https://in.search.yahoo.com/")));
    } else if (searchtext == 'Bing') {
      inAppWebViewController.loadUrl(
          urlRequest: URLRequest(url: WebUri("https://www.bing.com/")));
    } else if (searchtext == 'Duck Duck Go') {
      inAppWebViewController.loadUrl(
          urlRequest: URLRequest(url: WebUri("https://duckduckgo.com/")));
    }
    notifyListeners();
  }

  void updateSearchEngineGroupValue(String value) {
    groupValue = value;
    notifyListeners();
  }
   
  void searchEngines() {
    if (searchtext == 'Google') {
      inAppWebViewController.loadUrl(
          urlRequest: URLRequest(
              url: WebUri(
                  "https://www.google.com/search?q=$newsearchtext&rlz=1C1ONGR_enIN1095IN1095&oq=hi&gs_lcrp=EgZjaHJvbWUqDggAEEUYJxg7GIAEGIoFMg4IABBFGCcYOxiABBiKBTIGCAEQRRg7Mg0IAhAAGIMBGLEDGIAEMg0IAxAuGIMBGLEDGIAEMhAIBBAAGIMBGLEDGIAEGIoFMg0IBRAAGIMBGLEDGIAEMhYIBhAuGIMBGMcBGLEDGNEDGIAEGIoFMgcIBxAAGIAEMgcICBAAGIAEMhAICRAuGIMBGLEDGIAEGIoF0gEJMTIzNmowajE1qAIJsAIB&sourceid=chrome&ie=UTF-8")));
    } else if (searchtext == 'Yahoo') {
      inAppWebViewController.loadUrl(
          urlRequest: URLRequest(
              url: WebUri(
                  "https://in.search.yahoo.com/search;_ylt=AwrPoYNX0lFm3wcpV0y7HAx.;_ylc=X1MDMjExNDcyMzAwMwRfcgMyBGZyA2NybWFzBGZyMgNzYi10b3AEZ3ByaWQDZlRUNGtwSXdUSjZmZURhT2FPdnRXQQRuX3JzbHQDMARuX3N1Z2cDMTAEb3JpZ2luA2luLnNlYXJjaC55YWhvby5jb20EcG9zAzAEcHFzdHIDBHBxc3RybAMwBHFzdHJsAzExBHF1ZXJ5A2ZsdXR0ZXIlMjBkZXYEdF9zdG1wAzE3MTY2MzgzMDE-?p=$newsearchtext &fr2=sb-top&fr=crmas&vm=r")));
    } else if (searchtext == 'Bing') {
      inAppWebViewController.loadUrl(
          urlRequest: URLRequest(
              url: WebUri(
                  "https://www.bing.com/search?q=$newsearchtext&qs=n&form=QBRE&sp=-1&lq=0&pq=flutter+dev&sc=19-11&sk=&cvid=B4B782306ED143AE9326650EBDDC17DC&ghsh=0&ghacc=0&ghpl=")));
    } else if (searchtext == 'Duck Duck Go') {
      inAppWebViewController.loadUrl(
          urlRequest: URLRequest(
              url: WebUri("https://duckduckgo.com/?q=$newsearchtext&ia=web")));
    }
    notifyListeners();
  }

  Future<void> checkIfShouldGoBack() async {

    // print('$currentUrl ----------------------------------');

    if (currentUrl == 'Google' ||
        currentUrl == 'Yahoo India' ||
        currentUrl == 'Bing' ||
        currentUrl == 'DuckDuckGo — Privacy, simplified.') {
      // print('$currentUrl ----------------------------------');
      isButtonEnabled = false;
      // print(object);
      notifyListeners();
    } else {
      // print(" else part-------------------------------------------");
      isButtonEnabled = await inAppWebViewController.canGoBack();
      // print('$isButtonEnabled');
      notifyListeners();
    }
  }

  void updateSearchedText(String text) {
    newsearchtext = text;
    notifyListeners();
  }
}
