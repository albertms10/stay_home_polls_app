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
        title = doc.data['title'] ?? '',
        type = doc.data['type'] ?? '',
        options = doc.data['options'] != null
            ? (doc.data['options'] as List<dynamic>).cast<String>()
            : [],
        createdAt = doc.data['createdAt'],
        location = doc.data['location'],
        isAuth = doc.data['isAuth'] ?? false,
        voteValue = doc.data['voteValue'],
        voteCount = doc.data['voteCount'] ?? 0,
        dismissed = doc.data['dismissed'] ?? false,
        finished = doc.data['finished'] ?? true;

  Map<String, dynamic> genericToJson() => {
        "title": title,
        "type": type,
        "options": options,
        "createdAt": createdAt,
        "location": location,
        "voteCount": voteCount,
      };

  Map<String, dynamic> userToJson() => {
        "isAuth": isAuth,
        "type": type,
        "voteValue": voteValue,
        "dismissed": dismissed,
        "finished": finished,
      };

  @override
  String toString() => '$id $title, $type poll';
}

class SliderPoll extends Poll {
  double voteAverage;

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

  @override
  SliderPoll.fromFirestore(DocumentSnapshot doc)
      : voteAverage = doc.data['voteAverage'] ?? 0,
        super.fromFirestore(doc);

  @override
  Map<String, dynamic> genericToJson() => {
        ...super.genericToJson(),
        "voteAverage": voteAverage,
      };

  @override
  String toString() {
    return super.toString() + ' (${options[0]}, ${options[1]})';
  }
}

class ChoicePoll extends Poll {
  List<int> optionsVoteCount;

  ChoicePoll.fromPoll(Poll poll, [this.optionsVoteCount])
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
        "optionsVoteCount": optionsVoteCount,
      };

  @override
  String toString() {
    return super.toString() + ' (${options.length} options)';
  }
}

List<Poll> mapQueryPoll(QuerySnapshot query) {
  final List<DocumentSnapshot> docs = query.documents;
  return docs.map((doc) {
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
