import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_copy/createBody.dart';
import 'package:insta_copy/createBottom.dart';
import 'package:insta_copy/createHeader.dart';

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createHeader().runAppBar(),
      body: Body(),
      bottomNavigationBar: Bottom(),
    );
  }
}