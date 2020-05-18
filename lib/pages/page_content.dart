import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageContent extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> children;
  final String emptyMessage;

  PageContent({
    @required this.tabs,
    @required this.children,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<String>.value(
      value: emptyMessage,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: 50.0,
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Theme.of(context).accentColor,
                tabs: tabs,
              ),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: children,
          ),
        ),
      ),
    );
  }
}
