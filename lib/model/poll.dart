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

  Poll({
    @required this.id,
    @required this.title,
    @required this.options,
    this.createdAt,
    this.location,
    this.isAuth = false,
    this.voteValue,
  });

  Poll.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        title = doc.data['title'] ?? 'Title',
        options = (doc.data['options'] as List<dynamic>).cast<String>(),
        createdAt = doc.data['createdAt'],
        location = doc.data['location'],
        isAuth = doc.data['isAuth'] ?? false,
        voteValue = doc.data['voteValue'] ?? 0;

  toJson() => {
        "title": title,
        "options": options,
        "createdAt": createdAt,
        "location": location,
        "isAuth": isAuth,
        "voteValue": voteValue,
      };
}

class SliderPoll extends Poll {
  int voteAverage;
  int voteCount;

  SliderPoll({
    @required id,
    @required title,
    @required options,
    createdAt,
    location,
    isAuth,
    voteValue,
    this.voteAverage,
    this.voteCount,
  }) : super(
          id: id,
          createdAt: createdAt,
          location: location,
          options: options,
          title: title,
          isAuth: isAuth,
          voteValue: voteValue,
        );

  SliderPoll.fromFirestore(DocumentSnapshot doc)
      : voteAverage = doc.data['voteAverage'] ?? 0,
        voteCount = doc.data['voteCount'] ?? 0,
        super.fromFirestore(doc);

  toJson() => {
        ...super.toJson(),
        "voteAverage": voteAverage,
        "voteCount": voteCount,
      };
}

class ChoicePoll extends Poll {
  List<int> voteCount;

  ChoicePoll({
    @required id,
    @required title,
    @required options,
    createdAt,
    location,
    isAuth,
    voteValue,
    this.voteCount,
  }) : super(
          id: id,
          createdAt: createdAt,
          location: location,
          options: options,
          title: title,
          isAuth: isAuth,
          voteValue: voteValue,
        );

  ChoicePoll.fromFirestore(DocumentSnapshot doc)
      : voteCount = (doc.data['voteCount'] as List<dynamic>).cast<int>(),
        super.fromFirestore(doc);

  toJson() => {
        ...super.toJson(),
        "voteCount": voteCount,
      };
}

Stream<List<Poll>> pollListSnapshots() {
  return Firestore.instance
      .collection('polls')
      .orderBy('createdAt')
      .snapshots()
      .map((QuerySnapshot query) {
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
  });
}
