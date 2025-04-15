// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'author_bloc.dart';

@immutable
class AuthorState {
  final AuthorStyle updatedAuthorStyle;

  const AuthorState({required this.updatedAuthorStyle});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'updatedAuthorStyle': updatedAuthorStyle.toMap(),
    };
  }

  factory AuthorState.fromMap(Map<String, dynamic> map) {
    return AuthorState(
      updatedAuthorStyle: AuthorStyle.fromMap((map["updatedAuthorStyle"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorState.fromJson(String source) => AuthorState.fromMap(json.decode(source) as Map<String, dynamic>);
}
