import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add a month'),
        ),
      ),
      body: const Center(child: Text('ADD A PAGE PLACEHOLDER'),),
    );
  }
}
