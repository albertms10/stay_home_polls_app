import 'package:cloud_firestore/cloud_firestore.dart';

class Poll {
  String id;
  String title;
  List<String> options;
  Timestamp createdAt;
  GeoPoint location;
  bool isAuth;
  int voteValue;
  int voteCount;
  bool dismissed;

  Poll({
    this.id,
    this.title,
    this.options,
    this.createdAt,
    this.location,
    this.isAuth = false,
    this.voteValue,
    this.voteCount,
    this.dismissed = false,
  });

  Poll.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        title = doc.data['title'] ?? '',
        options = doc.data['options'] != null
            ? (doc.data['options'] as List<dynamic>).cast<String>()
            : [],
        createdAt = doc.data['createdAt'],
        location = doc.data['location'],
        isAuth = doc.data['isAuth'] ?? false,
        voteValue = doc.data['voteValue'],
        voteCount = doc.data['voteCount'],
        dismissed = doc.data['dismissed'] ?? false;

  Map<String, dynamic> toJson() => {
        "title": title,
        "options": options,
        "createdAt": createdAt,
        "location": location,
        "isAuth": isAuth,
        "voteValue": voteValue,
        "voteCount": voteCount,
      };

  @override
  String toString() => '$id $title, ${options.length} options';
}

class SliderPoll extends Poll {
  double voteAverage;

  SliderPoll({
    String id,
    String title,
    List<String> options,
    Timestamp createdAt,
    GeoPoint location,
    bool isAuth,
    int voteValue,
    int voteCount,
    bool dismissed,
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
          dismissed: dismissed,
        );

  SliderPoll.fromFirestore(DocumentSnapshot doc)
      : voteAverage = doc.data['voteAverage'] ?? 0,
        super.fromFirestore(doc);

  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "voteAverage": voteAverage,
      };
}

class ChoicePoll extends Poll {
  List<int> optionsVoteCount;

  int get totalCount =>
      optionsVoteCount.reduce((value, element) => value + element);

  ChoicePoll({
    String id,
    String title,
    List<String> options,
    Timestamp createdAt,
    GeoPoint location,
    bool isAuth,
    int voteValue,
    int voteCount,
    bool dismissed,
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
          dismissed: dismissed,
        );

  ChoicePoll.fromFirestore(DocumentSnapshot doc)
      : optionsVoteCount = doc.data['optionsVoteCount'] != null
            ? (doc.data['optionsVoteCount'] as List<dynamic>).cast<int>()
            : [],
        super.fromFirestore(doc);

  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'optionsVoteCount': optionsVoteCount,
      };
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
