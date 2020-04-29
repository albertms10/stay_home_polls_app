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
}
