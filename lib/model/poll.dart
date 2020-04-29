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

  Poll.fromMap(Map snapshot, String id)
      : id = id ?? '',
        title = snapshot['title'] ?? '',
        options = snapshot['options'] ?? [],
        createdAt = snapshot['createdAt'] ?? null,
        location = snapshot['location'] ?? null,
        isAuth = snapshot['isAuth'] ?? false,
        voteValue = snapshot['voteValue'] ?? 0;

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

  SliderPoll.fromMap(Map snapshot, String id)
      : voteAverage = snapshot['voteAverage'] ?? 0,
        voteCount = snapshot['voteCount'] ?? 0,
        super.fromMap(snapshot, id);

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

  ChoicePoll.fromMap(Map snapshot, String id)
      : voteCount = snapshot['voteCount'] ?? [],
        super.fromMap(snapshot, id);

  toJson() => {
        ...super.toJson(),
        "voteCount": voteCount,
      };
}
