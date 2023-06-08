// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String? localId;
  String? id;
  String? name;
  String? lastName;
  String? img = "";
  User({
    this.localId,
    this.id,
    this.name,
    this.lastName,
    this.img,
  });

  User copyWith({
    String? localId,
    String? id,
    String? name,
    String? lastName,
    String? img,
  }) {
    return User(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'localId': localId,
      'id': id,
      'name': name,
      'lastName': lastName,
      'img': img,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      localId: map['localId'] != null ? map['localId'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(localId: $localId, id: $id, name: $name, lastName: $lastName, img: $img)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.localId == localId &&
        other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.img == img;
  }

  @override
  int get hashCode {
    return localId.hashCode ^
        id.hashCode ^
        name.hashCode ^
        lastName.hashCode ^
        img.hashCode;
  }
}
