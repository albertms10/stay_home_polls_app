import 'package:cloud_firestore/cloud_firestore.dart';
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

  static vote(Poll poll, int value, [bool isAuth = false]) {
    // TODO: Refactor this
    String userId = 'Ap8s7eym7sY32CnuGIgM';

    Firestore.instance
        .collection('users/$userId/polls')
        .document(poll.id)
        .setData({
      'isAuth': isAuth,
      'type': poll is SliderPoll ? 'slider' : 'choice',
      'voteValue': value,
    });

    Firestore.instance.collection('polls').document(poll.id).updateData({
      'voteCount': poll.voteCount + 1,
      if (poll is ChoicePoll)
      // TODO: Refactor replace method (?)
        'optionsVoteCount': poll.optionsVoteCount
          ..replaceRange(value, value + 1, [poll.optionsVoteCount[value] + 1])
    });
  }
}
