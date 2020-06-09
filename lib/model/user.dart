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

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "polls": polls,
      };

  Stream<List<Poll>> pollsSnapshots() => Firestore.instance
      .collection('users/$id/polls')
      .snapshots()
      .map(mapQueryPoll);

  void addPoll(Poll poll) async {
    final ref = Firestore.instance;

    final pollRef = await ref.collection('polls').add(poll.genericToJson());

    ref
        .collection('users/$id/polls')
        .document(pollRef.documentID)
        .setData(poll.userToJson());
  }

  void vote(Poll poll, int value) async {
    final ref = Firestore.instance;

    ref.collection('users/$id/polls').document(poll.id).updateData({
      'voteValue': value,
      'finished': false,
    });

    ref.collection('polls').document(poll.id).updateData({
      'voteCount': poll.voteCount + 1,
      if (poll is SliderPoll)
        'voteAverage':
            poll.voteAverage + (value - poll.voteAverage) / (poll.voteCount + 1)
      else if (poll is ChoicePoll)
        'optionsVoteCount': poll.optionsVoteCount
          ..replaceRange(value, value + 1, [poll.optionsVoteCount[value] + 1])
    });

    Future.delayed(const Duration(seconds: 5)).then(
        (_) => ref.collection('users/$id/polls').document(poll.id).updateData({
              'finished': true,
            }));
  }

  void dismiss(Poll poll) => Firestore.instance
          .collection('users/$id/polls')
          .document(poll.id)
          .setData({
        'dismissed': true,
        'type': poll.type,
      });
}
