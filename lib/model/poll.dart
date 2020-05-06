import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class Poll {
  final String id;
  final String title;
  final List<String> options;
  final Timestamp createdAt;
  final GeoPoint location;
  final bool isAuth;
  final int voteValue;
  final int voteCount;

  Poll({
    @required this.id,
    @required this.title,
    @required this.options,
    this.createdAt,
    this.location,
    this.isAuth = false,
    this.voteValue,
    this.voteCount,
  });

  Poll.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        title = doc.data['title'] ?? 'Title',
        options = (doc.data['options'] as List<dynamic>).cast<String>(),
        createdAt = doc.data['createdAt'],
        location = doc.data['location'],
        isAuth = doc.data['isAuth'] ?? false,
        voteValue = doc.data['voteValue'] ?? 0,
        voteCount = doc.data['voteCount'] ?? 0;

  toJson() => {
        "title": title,
        "options": options,
        "createdAt": createdAt,
        "location": location,
        "isAuth": isAuth,
        "voteValue": voteValue,
        "voteCount": voteCount,
      };
}

class SliderPoll extends Poll {
  double voteAverage;

  SliderPoll({
    @required id,
    @required title,
    @required options,
    createdAt,
    location,
    isAuth,
    voteValue,
    voteCount,
    this.voteAverage,
  }) : super(
          id: id,
          createdAt: createdAt,
          location: location,
          options: options,
          title: title,
          isAuth: isAuth,
          voteValue: voteValue,
          voteCount: voteCount,
        );

  SliderPoll.fromFirestore(DocumentSnapshot doc)
      : voteAverage = doc.data['voteAverage'] ?? 0,
        super.fromFirestore(doc);

  toJson() => {
        ...super.toJson(),
        "voteAverage": voteAverage,
      };
}

class ChoicePoll extends Poll {
  List<int> optionsVoteCount;

  int get totalCount =>
      optionsVoteCount.reduce((value, element) => value + element);

  ChoicePoll({
    @required id,
    @required title,
    @required options,
    createdAt,
    location,
    isAuth,
    voteValue,
    voteCount,
    this.optionsVoteCount,
  }) : super(
          id: id,
          createdAt: createdAt,
          location: location,
          options: options,
          title: title,
          isAuth: isAuth,
          voteValue: voteValue,
          voteCount: voteCount,
        );

  ChoicePoll.fromFirestore(DocumentSnapshot doc)
      : optionsVoteCount =
            (doc.data['optionsVoteCount'] as List<dynamic>).cast<int>(),
        super.fromFirestore(doc);

  toJson() => {
        ...super.toJson(),
        "optionsVoteCount": optionsVoteCount,
      };
}

List<Poll> mapQueryPoll(QuerySnapshot query) {
  final List<DocumentSnapshot> docs = query.documents;
  return docs.map((doc) {
    switch (doc.data['type']) {
      case 'slider':
        return SliderPoll.fromFirestore(doc);
      case 'choice':
        return ChoicePoll.fromFirestore(doc);
      default:
        return null;
    }
  }).toList();
}

Stream<List<Poll>> popularPollListSnapshots() {
  return Firestore.instance
      .collection('polls')
      .orderBy('voteCount', descending: true)
      .snapshots()
      .map(mapQueryPoll);
}

Stream<List<Poll>> latestPollListSnapshots() {
  return Firestore.instance
      .collection('polls')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(mapQueryPoll);
}
