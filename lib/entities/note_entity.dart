import 'package:hive/hive.dart';
import 'package:local_note/models/note_model.dart';
import 'package:local_note/utils/string_util.dart';

part 'note_entity.g.dart';

@HiveType(typeId: 0)
class NoteEntity extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  String password;

  @HiveField(4)
  String date;

  NoteEntity(this.id, this.title, this.note, this.password, this.date);
}

extension NoteEntityExtension on NoteEntity {
  NoteModel toModel() =>
      NoteModel(id, title.decode, note.decode, password.decode, date.decode);
}
