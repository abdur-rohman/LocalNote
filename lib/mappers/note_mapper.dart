import 'package:local_note/entities/note_entity.dart';
import 'package:local_note/models/note_model.dart';

abstract class NoteMapper {
  List<NoteModel> toModelList(List<NoteEntity> entities);
}

class NoteMapperImpl implements NoteMapper {
  @override
  List<NoteModel> toModelList(List<NoteEntity> entities) =>
      entities.map<NoteModel>((e) => e.toModel()).toList();
}
