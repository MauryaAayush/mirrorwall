import 'package:flutter/material.dart';

class offLine_Code extends StatelessWidget {
  const offLine_Code({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 450,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/gifs/giphy.gif'),
        ),
      ),
    );
  }
}