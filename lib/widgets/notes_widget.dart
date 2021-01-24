import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_note/providers/note_provider.dart';
import 'package:local_note/utils/color_util.dart';
import 'package:local_note/utils/view_util.dart';
import 'package:local_note/views/note_view.dart';
import 'package:local_note/widgets/text_input_widget.dart';
import 'package:provider/provider.dart';

class NotesWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey;

  const NotesWidget({
    Key key,
    this.globalKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
        builder: (context, provider, _) => ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              final data = provider.notes[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: colorCard.withOpacity(.5),
                child: InkWell(
                  onTap: () {
                    if (data.password.isNotEmpty && !data.isValid) {
                      provider.fillPassword(index);

                      showSnackBar(globalKey.currentState,
                          "Fill the password first, because your password isn't valid");
                    } else {
                      provider.bindData(data);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => NoteView(
                                    model: data,
                                  )));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: colorDanger,
                            ),
                            splashRadius: 24,
                            onPressed: () => provider.deleteNote(data)),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                data.isValid ? data.title : "*************",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                data.isValid
                                    ? data.note
                                    : "*************************",
                                style: TextStyle(
                                    fontSize: 16, color: colorSecondary),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.all(8),
                              child: Text(
                                  DateFormat("EEEE, dd MMMM yyyy - HH:mm:ss ")
                                      .format(DateTime.parse(data.date)),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ),
                            if (data.isOpen && data.password.isNotEmpty)
                              TextInputWidget(
                                label: "Password",
                                padding: 8,
                                controller: data.controller,
                                onChanged: (value) =>
                                    provider.checkPassword(index, value),
                                inputType: TextInputType.visiblePassword,
                                isPassword: true,
                              )
                          ],
                        )),
                        if (data.password.isNotEmpty)
                          IconButton(
                              icon: Icon(
                                  data.isOpen ? Icons.lock_open : Icons.lock,
                                  color: colorPrimary),
                              splashRadius: 24,
                              onPressed: () => provider.openPassword(index))
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
