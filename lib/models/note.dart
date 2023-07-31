import 'package:freezed_annotation/freezed_annotation.dart';
part 'note.g.dart';
part 'note.freezed.dart';

@Freezed(fromJson: true, toJson: true)
class Note with _$Note {
  const factory Note(
    String id,
    String title,
    String note,
  ) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
