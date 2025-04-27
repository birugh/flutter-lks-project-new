import 'package:flutter/material.dart';
import 'package:lks_project_new/navigation_bar.dart';

class ListProductStateful extends StatefulWidget {
  const ListProductStateful({super.key});

  @override
  State<ListProductStateful> createState() => _ListProductStatefulState();
}

class _ListProductStatefulState extends State<ListProductStateful> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     body: Column(

     ), 
     bottomNavigationBar: NavigationBarStateful(initialIndex: 0,),
    );
  }
}