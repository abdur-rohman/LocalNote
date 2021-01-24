import 'package:flutter/material.dart';
import 'package:local_note/models/note_model.dart';
import 'package:local_note/providers/base_provider.dart';
import 'package:local_note/repos/note_repository.dart';
import 'package:provider/provider.dart';

class NoteProvider extends BaseProvider {
  final NoteRepository _repository;

  static NoteProvider unListen(BuildContext context) =>
      Provider.of<NoteProvider>(context, listen: false);

  List<NoteModel> _notes;
  List<NoteModel> get notes => _notes;

  TextEditingController noteController = TextEditingController(),
      titleController = TextEditingController(),
      passwordController = TextEditingController();

  bool _isSecure = false;
  bool get isSecure => _isSecure;
  set isSecure(bool value) {
    _isSecure = value;

    notifyListeners();
  }

  NoteProvider(this._repository);

  Future<List<NoteModel>> getAllNotes() {
    return _repository.getAllNotes().then((value) {
      _notes = value;
      _notes.sort((a, b) => b.id.compareTo(a.id));
      return _notes;
    });
  }

  void createNote() async {
    state = Loading();

    try {
      final date = DateTime.now();
      final model = NoteModel(
          date.microsecondsSinceEpoch,
          titleController.text,
          noteController.text,
          isSecure ? passwordController.text : "",
          date.toIso8601String());
      final note = await _repository.createNote(model);
      _notes.insert(0, note);

      noteController.clear();
      titleController.clear();
      passwordController.clear();

      _isSecure = false;

      state = Success();

      backToIdle();
    } catch (e) {
      state = Error(e?.message ?? "Oops something went wrong");

      backToIdle();
    }
  }

  void updateNote(NoteModel model) async {
    state = Loading();

    try {
      model.note = noteController.text;
      model.title = titleController.text;
      model.password = isSecure ? passwordController.text : "";

      final note = await _repository.updateNote(model);
      final index = _notes.indexWhere((element) => element.id == note.id);

      _notes[index] = note;

      bindData(note);

      state = Success();

      backToIdle();
    } catch (e) {
      state = Error(e?.message ?? "Oops something went wrong");

      backToIdle();
    }
  }

  void deleteNote(NoteModel model) async {
    state = Loading();

    try {
      final note = await _repository.deleteNote(model);
      final index = _notes.indexWhere((element) => element.id == note.id);

      _notes.removeAt(index);

      state = Success();

      backToIdle();
    } catch (e) {
      state = Error(e?.message ?? "Oops something went wrong");

      backToIdle();
    }
  }

  void fillPassword(int index) {
    final note = _notes[index];
    note.isOpen = true;

    _notes[index] = note;

    notifyListeners();
  }

  void openPassword(int index) {
    final note = _notes[index];
    note.isOpen = !note.isOpen;

    if (!note.isOpen) {
      note.controller.clear();
      note.isValid = false;
    }

    _notes[index] = note;

    notifyListeners();
  }

  void checkPassword(int index, String password) {
    final note = _notes[index];
    note.isValid = note.password == password;

    _notes[index] = note;

    notifyListeners();
  }

  void bindData(NoteModel model) {
    passwordController.text = model != null ? model.password : "";
    titleController.text = model != null ? model.title : "";
    noteController.text = model != null ? model.note : "";

    _isSecure = model != null ? model.password.isNotEmpty : false;

    if (!isSecure) passwordController.clear();
  }
}
