import 'package:flutter/material.dart';
import 'package:local_note/entities/note_entity.dart';
import 'package:local_note/utils/string_util.dart';

class NoteModel {
  int id;
  String title, note, password, date;
  bool isOpen, isValid;
  TextEditingController controller = TextEditingController();

  NoteModel(this.id, this.title, this.note, this.password, this.date) {
    isOpen = password.isEmpty;
    isValid = password.isEmpty;
  }
}

extension NoteModelExtension on NoteModel {
  NoteEntity toEntity() =>
      NoteEntity(id, title.encode, note.encode, password.encode, date.encode);
}
