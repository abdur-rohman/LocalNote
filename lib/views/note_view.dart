import 'package:flutter/material.dart';
import 'package:local_note/models/note_model.dart';
import 'package:local_note/providers/note_provider.dart';
import 'package:local_note/utils/color_util.dart';
import 'package:local_note/utils/view_util.dart';
import 'package:local_note/widgets/app_bar_widget.dart';
import 'package:local_note/widgets/button_widget.dart';
import 'package:local_note/widgets/state_widget.dart';
import 'package:local_note/widgets/text_input_widget.dart';
import 'package:provider/provider.dart';

class NoteView extends StatelessWidget {
  final NoteModel model;

  const NoteView({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCreate = model == null;
    final text = isCreate ? "Create a new Note" : "Update Note";

    return Scaffold(
      appBar: AppBarWidget(
        text: text,
      ),
      body: Consumer<NoteProvider>(
        builder: (context, provider, _) {
          return StateWidget(
              viewState: provider.state,
              context: context,
              idle: SingleChildScrollView(
                child: Column(
                  children: [
                    TextInputWidget(
                        label: "Title",
                        controller: provider.titleController,
                        inputType: TextInputType.text),
                    TextInputWidget(
                        label: "Note",
                        controller: provider.noteController,
                        minLines: 2,
                        maxLines: 4,
                        inputType: TextInputType.text),
                    ListTile(
                      leading: Checkbox(
                          activeColor: Colors.blueGrey,
                          value: provider.isSecure,
                          onChanged: (value) => provider.isSecure = value),
                      title: Text(
                        "Secure note",
                        style: TextStyle(color: colorPrimary, fontSize: 16),
                      ),
                    ),
                    if (provider.isSecure)
                      TextInputWidget(
                        label: "Password",
                        controller: provider.passwordController,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                      ),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.all(16),
                      child: ButtonWidget(
                          text: text,
                          onClick: () {
                            if (provider.isSecure &&
                                provider.passwordController.text.length < 8) {
                              showSnackBar(Scaffold.of(context),
                                  "Password at least eight chars long");
                            } else if (provider.titleController.text.length <
                                5) {
                              showSnackBar(Scaffold.of(context),
                                  "Title at least five chars long");
                            } else if (provider.noteController.text.length <
                                3) {
                              showSnackBar(Scaffold.of(context),
                                  "Note at least three chars long");
                            } else {
                              isCreate
                                  ? provider.createNote()
                                  : provider.updateNote(model);
                            }
                          }),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
