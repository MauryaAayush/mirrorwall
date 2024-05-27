import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Providers/All_Providers.dart';

import 'Views/Main_Screen/Main_Screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        )
      ],
      child: const MirrorWall(),
    ),
  );
}

class MirrorWall extends StatelessWidget {
  const MirrorWall({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
