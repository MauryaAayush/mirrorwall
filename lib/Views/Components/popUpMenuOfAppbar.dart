import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/All_Providers.dart';
import '../History Page.dart';

class PopUpofAppBar extends StatelessWidget {
  const PopUpofAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
    );
  }
}