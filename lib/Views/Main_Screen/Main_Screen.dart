import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import '../../Providers/All_Providers.dart';
import '../../Utils/Global_Variables.dart';
import '../Components/Header_txtField.dart';
import '../Components/popUpMenuOfAppbar.dart';
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
        actions: const [
          SizedBox(
            height: 40,
            width: 350,
            child: Header_TextFormField(),
          ),
          PopUpofAppBar(),
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

                    // for the add to fav site
                    onLoadStop: (controller, url) async {

                      Provider.of<MainProvider>(context, listen: false)
                          .addtoHistory();

                      await Provider.of<MainProvider>(context, listen: false)
                          .setcurrentUrl();

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



