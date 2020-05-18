import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';

class User {
  final String id;
  String displayName;
  List<Poll> polls;

  User({
    @required this.id,
    this.displayName,
    this.polls,
  });

  User.fromMap(Map snapshot, String id)
      : id = id ?? '',
        displayName = snapshot['displayName'] ?? '',
        polls = snapshot['polls'] ?? [];

  toJson() => {
        "displayName": displayName,
        "polls": polls,
      };

  Stream<List<Poll>> pollsSnapshots() => Firestore.instance
      .collection('users/$id/polls')
      .snapshots()
      .map(mapQueryPoll);

  vote(Poll poll, int value, [bool isAuth = false]) {
    final ref = Firestore.instance;

    ref.collection('users/$id/polls').document(poll.id).setData({
      'isAuth': isAuth,
      'type': poll is SliderPoll ? 'slider' : 'choice',
      'voteValue': value,
    });

    ref.collection('polls').document(poll.id).updateData({
      'voteCount': poll.voteCount + 1,
      if (poll is SliderPoll)
        'voteAverage':
            poll.voteAverage + (value - poll.voteAverage) / (poll.voteCount + 1)
      else if (poll is ChoicePoll)
        // TODO: Refactor replace method (can be improved?)
        'optionsVoteCount': poll.optionsVoteCount
          ..replaceRange(value, value + 1, [poll.optionsVoteCount[value] + 1])
    });
  }

  dismiss(Poll poll) => Firestore.instance
          .collection('users/$id/polls')
          .document(poll.id)
          .setData({
        'dismissed': true,
        'type': poll is SliderPoll ? 'slider' : 'choice',
      });
}
