// ignore_for_file: file_names

import "package:flutter/material.dart";

class ImageViewsScreen extends StatelessWidget {
  const ImageViewsScreen({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.network(imageUrl),
          const BackButton(),
          Expanded(
            child: Align(
              alignment: Alignment.center,
            ),
          )
        ],
      )),
    );
  }
}
