import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/All_Providers.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search History'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: Provider.of<MainProvider>(context).historylist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.link),
                  trailing: IconButton(onPressed: () {
                    
                  }, icon: Icon(Icons.more_vert)),
                  title: Text(
                      Provider.of<MainProvider>(context).historylist[index]),
                );
                
              },
            )),
      ),
    );
  }
}
