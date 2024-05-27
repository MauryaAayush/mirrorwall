import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';


import '../../Providers/All_Providers.dart';
import '../../Utils/Global_Variables.dart';
import '../Components/Header_txtField.dart';
import '../History Page.dart';

PullToRefreshController pullToRefreshController = PullToRefreshController(
  onRefresh: () {
    inAppWebViewController.reload();
  },
);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        actions: [
          SizedBox(
            height: 40,
            width: 350,
            child: Header_TextFormField(),
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'Feedback') {
                showModalBottomSheet(
                  elevation: 10,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Consumer<MainProvider>(
                      builder: (context, mainProvider, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                child: Text(
                                  'Bookmarks',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                                height: 1,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: mainProvider.bookmarkList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          mainProvider.bookmarkList[index],
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.bookmark,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );



              } else if (value == 'History') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ));
              } else if (value == 'Engine') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Search Engines"),
                      content: Container(
                        height: 240,
                        width: 400,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    RadioListTile(
                                      title: Text(Provider
                                          .of<MainProvider>(context,
                                          listen: true)
                                          .searchEngineNames[index]),
                                      value: Provider
                                          .of<MainProvider>(context,
                                          listen: true)
                                          .searchEngineNames[index],
                                      groupValue: Provider
                                          .of<MainProvider>(context,
                                          listen: true)
                                          .groupValue,
                                      onChanged: (value) {
                                        Provider.of<MainProvider>(context,
                                            listen: false)
                                            .updateSearchEngineGroupValue(
                                            value!);
                                        Navigator.pop(context);
                                        Provider.of<MainProvider>(context,
                                            listen: false)
                                            .updateSearchEngine(value!);

                                        print(value);
                                      },
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            itemBuilder: (context) =>
            <PopupMenuEntry>[
              PopupMenuItem(value: 'Feedback', child: Text('Feedback')),
              PopupMenuItem(value: 'History', child: Text('History')),
              PopupMenuItem(value: 'Engine', child: Text('Search Engine')),
            ],
          ),
        ],
        // bottom:
      ),
      body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.data!.contains(ConnectivityResult.mobile) ||
                snapshot.data!.contains(ConnectivityResult.wifi)) {
              return Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri('https://www.google.com/'),
                    ),
                    onWebViewCreated: (controller) {
                      inAppWebViewController = controller;
                    },
                    onProgressChanged: (controller, progress) {
                      Provider.of<MainProvider>(context, listen: false)
                          .onchange_progress(progress);
                    },

                    // for the History add and show
                    onLoadStart: (controller, url) {
                      // Provider.of<MainProvider>(context, listen: false)
                      //     .setcurrentUrl(url.toString());

                      Provider.of<MainProvider>(context, listen: false)
                          .addtoHistory();
                    },

                    // for the add to fav site
                    onLoadStop: (controller, url) async {
                      // Provider.of<MainProvider>(context, listen: false)
                      //     .setcurrentUrl(url.toString());
                      //
                      // Provider.of<MainProvider>(context, listen: false)
                      //     .addtoHistory();


                      await Provider.of<MainProvider>(context, listen: false)
                          .setcurrentUrl();

                      // await Provider.of<MainProvider>(context, listen: false)
                      //     .canGoBack();

                      await Provider.of<MainProvider>(context, listen: false)
                          .checkIfShouldGoBack();


                      await Provider.of<MainProvider>(context,listen: false)
                      .canGoForward();

                      await pullToRefreshController.endRefreshing();
                    },
                    pullToRefreshController: pullToRefreshController,
                  ),
                  (Provider
                      .of<MainProvider>(context, listen: true)
                      .progress <
                      1)
                      ? Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(
                      color: Colors.blueAccent,
                      value:
                      Provider
                          .of<MainProvider>(context, listen: true)
                          .progress,
                    ),
                  )
                      : Container(),
                ],
              );
            } else {
              return Center(
                child: Container(
                  height: 350,
                  width: 450,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/gifs/giphy.gif'),
                    ),
                  ),
                ),
              );
            }
          }),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  inAppWebViewController.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri('https://www.google.com/'),
                      ));
                },
                icon: const Icon(Icons.home)),
            IconButton(
                onPressed: () {
                  Provider.of<MainProvider>(context, listen: false)
                      .addtoBookMark();
                },
                icon: const Icon(Icons.bookmark_add_outlined)),

            // here is logic of back button

            IconButton(
                onPressed: Provider
                    .of<MainProvider>(context, listen: true)
                    .isButtonEnabled
                    ? () {
                   (Provider
                      .of<MainProvider>(context, listen: false)
                      .goBack());


                }
                    : null,
                icon: const Icon(Icons.chevron_left),
                iconSize: 30),
            IconButton(
              onPressed: () {
                inAppWebViewController.reload();
              },
              icon: const Icon(Icons.refresh),
              iconSize: 25,
            ),
            IconButton(

              onPressed: Provider
                  .of<MainProvider>(context, listen: true)
                  .isButtonForward
                  ? () {
                (Provider
                    .of<MainProvider>(context, listen: false)
                    .goForward());


              }
                  : null,

              icon: const Icon(Icons.chevron_right),
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }

}

