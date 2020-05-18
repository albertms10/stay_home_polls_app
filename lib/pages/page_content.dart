import 'package:flutter/material.dart';

class PageContent extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> children;

  PageContent({@required this.tabs, @required this.children});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 50.0,
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).primaryColor,
              tabs: tabs,
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: children,
        ),
      ),
    );
  }
}
