import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/pages/feed_content.dart';
import 'package:stay_home_polls_app/pages/user_content.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          FeedContent(),
          UserContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageController.page.floor(),
        onTap: (tabIndex) {
          setState(() {
            _pageController.jumpToPage(tabIndex);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text('Profile'),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        showUnselectedLabels: false,
      ),
    );
  }
}
