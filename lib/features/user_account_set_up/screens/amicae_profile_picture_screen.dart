import 'package:flutter/material.dart';

class AmicaeProfilePictureScreen extends StatelessWidget {
  final String documentId;

  const AmicaeProfilePictureScreen({required this.documentId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Picture'), automaticallyImplyLeading: false,),
      body: Center(
        child: Text('Document ID: $documentId'),
      ),
    );
  }
}
