import 'package:hive/hive.dart';
import 'package:local_note/utils/string_util.dart';
import 'package:local_note/entities/note_entity.dart';
import 'package:local_note/mappers/note_mapper.dart';
import 'package:local_note/models/note_model.dart';

abstract class NoteRepository {
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel> createNote(NoteModel note);
  Future<NoteModel> updateNote(NoteModel note);
  Future<NoteModel> deleteNote(NoteModel note);
}

class NoteRepositoryImpl implements NoteRepository {
  final Box<NoteEntity> _notes;
  final NoteMapper _mapper;

  NoteRepositoryImpl(this._notes, this._mapper);

  @override
  Future<NoteModel> createNote(NoteModel note) async {
    final entity = note.toEntity();

    await _notes.add(entity);

    return entity.toModel();
  }

  @override
  Future<NoteModel> deleteNote(NoteModel note) async {
    final entities = _notes.values.toList();

    final entity = entities.firstWhere((element) => note.id == element.id);

    if (entity != null) await entity.delete();

    return entity.toModel();
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final notes = _mapper.toModelList(_notes.values.toList());

    notes.sort((a, b) => a.id.compareTo(b.id));

    return notes;
  }

  @override
  Future<NoteModel> updateNote(NoteModel note) async {
    final entities = _notes.values.toList();

    final entity = entities.firstWhere((element) => note.id == element.id);

    if (entity != null) {
      entity.note = note.note.encode;
      entity.password = note.password.encode;

      await entity.save();
    }

    return entity.toModel();
  }
}
