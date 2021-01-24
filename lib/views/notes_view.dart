import 'package:flutter/material.dart';
import 'package:local_note/providers/note_provider.dart';
import 'package:local_note/views/note_view.dart';
import 'package:local_note/widgets/app_bar_widget.dart';
import 'package:local_note/widgets/button_widget.dart';
import 'package:local_note/widgets/keep_alive.dart';
import 'package:local_note/widgets/notes_widget.dart';
import 'package:local_note/widgets/state_widget.dart';

class NotesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeepAliveFutureBuilder(
      future: NoteProvider.unListen(context).getAllNotes(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Scaffold(
            body: ExceptionWidget(
              error: snapshot.error.toString(),
            ),
          );

        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingWidget();

        final key = GlobalKey<ScaffoldState>();

        return Scaffold(
          key: key,
          appBar: AppBarWidget(text: "Notes App"),
          body: Column(
            children: [
              Expanded(
                  child: NotesWidget(
                globalKey: key,
              )),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.all(32),
                child: ButtonWidget(
                    text: "Create a new Note",
                    onClick: () {
                      NoteProvider.unListen(context).bindData(null);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => NoteView()));
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
