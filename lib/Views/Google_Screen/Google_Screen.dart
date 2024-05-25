import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../Providers/All_Providers.dart';
import '../../Utils/Global_Variables.dart';

PullToRefreshController pullToRefreshController = PullToRefreshController(
  onRefresh: () {
    inAppWebViewController.reload();
  },
);

class GoogleScreen extends StatelessWidget {
  const GoogleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            height: 40,
            width: 350,
            child: TextFormField(
              controller: txtsearch,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.link_sharp),
                  suffixIcon: IconButton(
                      onPressed: () {
                        txtsearch.clear();
                      },
                      icon: Icon(Icons.cancel_outlined)),
                  hintText: 'Search or type URL',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  contentPadding: EdgeInsets.symmetric(vertical: 10)),
              onFieldSubmitted: (value) {
                Provider.of<MainProvider>(context, listen: false)
                    .search(txtsearch.text);

                inAppWebViewController.loadUrl(
                    urlRequest: URLRequest(
                        url: WebUri(
                            'https://www.google.com/search?q= ${Provider.of<MainProvider>(context, listen: false).searchtext}  &sca_esv=2358ec6357e7f4b8&sca_upv=1&sxsrf=ADLYWIIskdPoVtrMe3x9OTJOiDDBhSiqKA%3A1716531975549&ei=BzNQZsqGIcfd2roPxumH2AE&oq=flutter+a&gs_lp=Egxnd3Mtd2l6LXNlcnAiCWZsdXR0ZXIgYSoCCAEyCxAAGIAEGJECGIoFMg4QABiABBiRAhixAxiKBTILEAAYgAQYsQMYgwEyDRAAGIAEGLEDGBQYhwIyCxAAGIAEGJECGIoFMgsQABiABBixAxiDATIOEAAYgAQYkQIYsQMYigUyCxAAGIAEGJECGIoFMgUQABiABDIFEAAYgARIni9QqAlY1hxwAXgBkAEAmAHMAaAB3QKqAQUwLjEuMbgBA8gBAPgBAZgCA6AC6gLCAgcQIxiwAxgnwgIKEAAYsAMY1gQYR8ICBBAjGCfCAgoQIxiABBgnGIoFwgIIEAAYgAQYsQOYAwCIBgGQBgqSBwUxLjEuMaAHyw4&sclient=gws-wiz-serp')));
              },
            ),
          ),

          PopupMenuButton(

            itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
                value: 'Feedback',
                child: Text('Feedback')),
              PopupMenuItem(
                  value: 'History',
                  child: Text('History')),

              PopupMenuItem(
                  value: 'Engine',
                  child: Text('Search Engine')),
          ],),



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

                    onLoadStart: (controller, url) {
                      Provider.of<MainProvider>(context,listen: false).setcurrentUrl(url.toString());

                      Provider.of<MainProvider>(context,listen: false).addtoHistory();
                    },

                    onLoadStop: (controller, url) {
                      Provider.of<MainProvider>(context, listen: false)
                          .setcurrentUrl(url.toString());
                      pullToRefreshController.endRefreshing();
                    },
                    pullToRefreshController: pullToRefreshController,
                  ),
                  (Provider.of<MainProvider>(context, listen: true).progress <
                          1)
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: LinearProgressIndicator(
                            color: Colors.blueAccent,
                            value:
                                Provider.of<MainProvider>(context, listen: true)
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
                    color: Colors.blue,
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
                  Provider.of<MainProvider>(context,listen: false).addtoBookMark();
                }, icon: const Icon(Icons.bookmark_add_outlined)),
            IconButton(
              onPressed: () {
                inAppWebViewController.goBack();
              },
              icon: const Icon(Icons.chevron_left),
              iconSize: 32,
            ),
            IconButton(
              onPressed: () {
                inAppWebViewController.reload();
              },
              icon: const Icon(Icons.refresh),
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {
                inAppWebViewController.goForward();
              },
              icon: const Icon(Icons.chevron_right),
              iconSize: 32,
            ),
          ],
        ),
      ),
    );
  }
}
