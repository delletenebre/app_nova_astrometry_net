import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final EdgeInsets padding;

  const PageLayout({
    Key? key,
    required this.child,
    this.title = '',
    this.floatingActionButton,
    this.actions,
    this.padding = EdgeInsets.zero,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(
        child: child,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}