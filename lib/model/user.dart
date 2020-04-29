import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';

class User {
  String id;
  String displayName;
  String userName;
  List<Poll> polls;

  User({
    @required this.id,
    @required this.displayName,
    @required this.userName,
    this.polls,
  });
}
