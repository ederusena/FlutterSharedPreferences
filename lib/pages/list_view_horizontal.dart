import 'package:flutter/material.dart';
import 'package:trilhapp/shared/app_images.dart';

class ListViewPageHorizontal extends StatefulWidget {
  const ListViewPageHorizontal({super.key});

  @override
  State<ListViewPageHorizontal> createState() => _ListViewPageHorizontalState();
}

class _ListViewPageHorizontalState extends State<ListViewPageHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 2,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Card(
                elevation: 8,
                child: Image.asset(
                  AppImages.paisagem1,
                ),
              ),
              Card(
                elevation: 8,
                child: Image.asset(
                  AppImages.paisagem2,
                ),
              ),
              Card(
                elevation: 8,
                child: Image.asset(
                  AppImages.paisagem3,
                ),
              )
            ],
          ),
        ),
        Expanded(flex: 3, child: Container())
      ]),
    );
  }
}
