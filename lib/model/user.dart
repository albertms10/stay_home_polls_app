import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';

class User {
  final String id;
  String displayName;
  String userName;
  List<Poll> polls;

  User({
    @required this.id,
    @required this.displayName,
    @required this.userName,
    this.polls,
  });

  User.fromMap(Map snapshot, String id)
      : id = id ?? '',
        displayName = snapshot['displayName'] ?? '',
        userName = snapshot['userName'] ?? '',
        polls = snapshot['polls'] ?? [];

  toJson() => {
        "displayName": displayName,
        "userName": userName,
        "polls": polls,
      };
}
