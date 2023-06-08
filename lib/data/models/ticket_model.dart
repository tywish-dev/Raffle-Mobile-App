// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ticket {
  String? uid;
  String? count;
  Ticket({
    this.uid,
    this.count,
  });

  Ticket copyWith({
    String? uid,
    String? count,
  }) {
    return Ticket(
      uid: uid ?? this.uid,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'count': count,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      uid: map['uid'] != null ? map['uid'] as String : null,
      count: map['count'] != null ? map['count'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) =>
      Ticket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ticket(uid: $uid, count: $count)';

  @override
  bool operator ==(covariant Ticket other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.count == count;
  }

  @override
  int get hashCode => uid.hashCode ^ count.hashCode;
}
