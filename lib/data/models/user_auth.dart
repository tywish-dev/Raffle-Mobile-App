// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserAuth {
  String email;
  String password;
  bool returnSecureToken = true;
  UserAuth({
    required this.email,
    required this.password,
    required this.returnSecureToken,
  });

  UserAuth copyWith({
    String? email,
    String? password,
    bool? returnSecureToken,
  }) {
    return UserAuth(
      email: email ?? this.email,
      password: password ?? this.password,
      returnSecureToken: returnSecureToken ?? this.returnSecureToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'returnSecureToken': returnSecureToken,
    };
  }

  factory UserAuth.fromMap(Map<String, dynamic> map) {
    return UserAuth(
      email: map['email'] as String,
      password: map['password'] as String,
      returnSecureToken: map['returnSecureToken'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuth.fromJson(String source) =>
      UserAuth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserAuth(email: $email, password: $password, returnSecureToken: $returnSecureToken)';

  @override
  bool operator ==(covariant UserAuth other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.returnSecureToken == returnSecureToken;
  }

  @override
  int get hashCode =>
      email.hashCode ^ password.hashCode ^ returnSecureToken.hashCode;
}
