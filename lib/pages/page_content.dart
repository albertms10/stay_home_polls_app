import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/main.dart';

class PageContent extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> children;
  final String emptyMessage;

  const PageContent({
    @required this.tabs,
    @required this.children,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<String>.value(
      value: emptyMessage,
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              height: 50.0,
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                labelStyle: AppConstants.of(context)
                    .font
                    .copyWith(fontWeight: FontWeight.bold),
                labelColor: Theme.of(context).accentColor,
                tabs: tabs,
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
        ),
      ),
    );
  }
}
