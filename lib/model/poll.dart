import 'package:cloud_firestore/cloud_firestore.dart';

class Poll {
  String id;
  String title;
  String type;
  List<String> options;
  Timestamp createdAt;
  GeoPoint location;
  bool isAuth;
  int voteValue;
  int voteCount;
  bool dismissed;
  bool finished;

  Poll({
    this.id,
    this.title,
    this.type,
    this.options,
    this.createdAt,
    this.location,
    this.isAuth = false,
    this.voteValue,
    this.voteCount = 0,
    this.dismissed = false,
    this.finished = true,
  });

  Poll.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        title = doc.data['title'] as String ?? '',
        type = doc.data['type'] as String ?? '',
        options = doc.data['options'] != null
            ? (doc.data['options'] as List<dynamic>).cast<String>()
            : [],
        createdAt = doc.data['createdAt'] as Timestamp,
        location = doc.data['location'] as GeoPoint,
        isAuth = doc.data['isAuth'] as bool ?? false,
        voteValue = doc.data['voteValue'] as int,
        voteCount = doc.data['voteCount'] as int ?? 0,
        dismissed = doc.data['dismissed'] as bool ?? false,
        finished = doc.data['finished'] as bool ?? true;

  Map<String, dynamic> genericToJson() => {
        'title': title,
        'type': type,
        'options': options,
        'createdAt': createdAt,
        'location': location,
        'voteCount': voteCount,
      };

  Map<String, dynamic> userToJson() => {
        'isAuth': isAuth,
        'type': type,
        'voteValue': voteValue,
        'dismissed': dismissed,
        'finished': finished,
      };

  @override
  String toString() => '$id $title, $type poll';
}

class SliderPoll extends Poll {
  double voteAverage;

  SliderPoll({
    String id,
    String title,
    String type,
    List<String> options,
    Timestamp createdAt,
    GeoPoint location,
    bool isAuth,
    int voteValue,
    int voteCount,
    bool dismissed,
    bool finished,
    this.voteAverage,
  }) : super(
          id: id,
          title: title,
          type: 'slider',
          options: options,
          createdAt: createdAt,
          location: location,
          isAuth: isAuth,
          voteValue: voteValue,
          voteCount: voteCount,
          dismissed: dismissed,
          finished: finished,
        );

  SliderPoll.fromPoll(Poll poll, [this.voteAverage])
      : super(
          id: poll.id,
          title: poll.title,
          type: 'slider',
          options: poll.options,
          createdAt: poll.createdAt,
          location: poll.location,
          isAuth: poll.isAuth,
          voteValue: poll.voteValue,
          voteCount: poll.voteCount,
          dismissed: poll.dismissed,
          finished: poll.finished,
        );

  @override
  SliderPoll.fromFirestore(DocumentSnapshot doc)
      : voteAverage = doc.data['voteAverage'] as double ?? 0.0,
        super.fromFirestore(doc);

  @override
  Map<String, dynamic> genericToJson() => {
        ...super.genericToJson(),
        'voteAverage': voteAverage,
      };

  @override
  String toString() {
    return super.toString() + ' (${options.first}, ${options.last})';
  }
}

class ChoicePoll extends Poll {
  List<int> optionsVoteCount;

  ChoicePoll({
    String id,
    String title,
    String type,
    List<String> options,
    Timestamp createdAt,
    GeoPoint location,
    bool isAuth,
    int voteValue,
    int voteCount,
    bool dismissed,
    bool finished,
    this.optionsVoteCount,
  }) : super(
          id: id,
          title: title,
          type: 'choice',
          options: options,
          createdAt: createdAt,
          location: location,
          isAuth: isAuth,
          voteValue: voteValue,
          voteCount: voteCount,
          dismissed: dismissed,
          finished: finished,
        );

  ChoicePoll.fromPoll(Poll poll, {this.optionsVoteCount})
      : super(
          id: poll.id,
          title: poll.title,
          type: 'choice',
          options: poll.options,
          createdAt: poll.createdAt,
          location: poll.location,
          isAuth: poll.isAuth,
          voteValue: poll.voteValue,
          voteCount: poll.voteCount,
          dismissed: poll.dismissed,
          finished: poll.finished,
        );

  int get totalCount =>
      optionsVoteCount.reduce((value, element) => value + element);

  @override
  ChoicePoll.fromFirestore(DocumentSnapshot doc)
      : optionsVoteCount = doc.data['optionsVoteCount'] != null
            ? (doc.data['optionsVoteCount'] as List<dynamic>).cast<int>()
            : [],
        super.fromFirestore(doc);

  @override
  Map<String, dynamic> genericToJson() => {
        ...super.genericToJson(),
        'optionsVoteCount': optionsVoteCount,
      };

  @override
  String toString() {
    return super.toString() + ' (${options.length} options)';
  }
}

List<Poll> mapQueryPoll(QuerySnapshot query) {
  return query.documents.map((doc) {
    if (doc.data['dismissed'] != null && doc.data['dismissed']) return null;

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

Stream<List<Poll>> popularPollListSnapshots() => Firestore.instance
    .collection('polls')
    .orderBy('voteCount', descending: true)
    .snapshots()
    .map(mapQueryPoll);

Stream<List<Poll>> latestPollListSnapshots() => Firestore.instance
    .collection('polls')
    .orderBy('createdAt', descending: true)
    .snapshots()
    .map(mapQueryPoll);
