import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Providers/All_Providers.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('saved Pages'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: Provider.of<MainProvider>(context).bookmarkList.length,
            itemBuilder: (context, index) =>
                Text(Provider.of<MainProvider>(context).bookmarkList[index]),
          ),
        ),
      ),
    );
  }
}
