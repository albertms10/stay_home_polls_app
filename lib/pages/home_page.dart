import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/main.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/pages/feed_content.dart';
import 'package:stay_home_polls_app/pages/new_poll.dart';
import 'package:stay_home_polls_app/pages/user_content.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({this.title});

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
      appBar: AppBar(
        title: Text(
          widget.title,
          style: AppConstants.of(context)
              .font
              .copyWith(fontWeight: FontWeight.bold),
        ),
        brightness: Brightness.dark,
        actions: [
          PopupMenuButton<String>(
            onSelected: (selected) {
              switch (selected) {
                case 'Log out':
                  return FirebaseAuth.instance.signOut();

                default:
                  return null;
              }
            },
            itemBuilder: (context) {
              return {'Log out'}.map((choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          FeedContent(),
          UserContent(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final poll = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NewPoll()),
          );

          if (poll != null && poll is Poll) {
            Provider.of<User>(context, listen: false).addPoll(poll);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _pageController.hasClients ? _pageController.page.floor() : 0,
        onTap: (tabIndex) {
          setState(() {
            _pageController.jumpToPage(tabIndex);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Me',
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
