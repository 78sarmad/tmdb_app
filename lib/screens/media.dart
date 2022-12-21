import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Media',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
