import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Poll {
  String id;
  String title;
  List<String> options;
  Timestamp createdAt;
  GeoPoint location;

  Poll({
    @required this.id,
    @required this.title,
    @required this.options,
    this.createdAt,
    this.location,
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
    this.voteAverage,
    this.voteCount,
  }) : super(
          id: id,
          createdAt: createdAt,
          location: location,
          options: options,
          title: title,
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
    this.voteCount,
  }) : super(
          id: id,
          createdAt: createdAt,
          location: location,
          options: options,
          title: title,
        );
}
