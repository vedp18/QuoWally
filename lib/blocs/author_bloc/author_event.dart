part of 'author_bloc.dart';

@immutable
sealed class AuthorEvent {}

final class AuthorChangedEvent extends AuthorEvent {
  final String newAuthorText;

  AuthorChangedEvent({required this.newAuthorText});

}

final class AuthorColorChangedEvent extends AuthorEvent {
  final Color newColor;

  AuthorColorChangedEvent({required this.newColor});
}

final class AuthorFontChangedEvent extends AuthorEvent {
  final String newFont;

  AuthorFontChangedEvent({required this.newFont});
}

final class AuthorFontStyleChangedEvent extends AuthorEvent {
  final FontStyle newFontStyle;

  AuthorFontStyleChangedEvent({required this.newFontStyle});
}

final class AuthorSizeChangedEvent extends AuthorEvent {
  final double newSize;

  AuthorSizeChangedEvent({required this.newSize});
}

final class AuthorWeightChangedEvent extends AuthorEvent {
  final FontWeight newWeight;

  AuthorWeightChangedEvent({required this.newWeight});
}

final class AuthorAlignmentChangedEvent extends AuthorEvent {
  final Alignment newAlignment;

  AuthorAlignmentChangedEvent({required this.newAlignment});

}
