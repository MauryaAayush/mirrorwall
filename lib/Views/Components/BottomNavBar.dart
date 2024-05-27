import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../Providers/All_Providers.dart';
import '../../Utils/Global_Variables.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}