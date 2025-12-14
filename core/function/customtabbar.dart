import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    this.length = 2,
    required this.title,
    required this.tabs,
    required this.children,
  });
  final int length;
  final String title;
  final List<Tab> tabs;

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: length,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 85, 208, 171),
          bottom: TabBar(tabs: tabs),
        ),
        body: TabBarView(children: children),
      ),
    );
  }
}
