import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/note_screen_controller.dart';
import 'package:notes/extensions/obj_extension.dart';
import 'package:notes/models/note.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key, @PathParam() this.id, this.note});
  final String? id;
  final Note? note;

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late NoteScreenController noteScreenController;

  late final TextEditingController titleTextController;
  late final TextEditingController noteTextController;

  @override
  void initState() {
    super.initState();
    widget.note.let((note) {
      titleTextController = TextEditingController(text: note?.title);
      noteTextController = TextEditingController(text: note?.note);
    });
    noteScreenController = Get.put(NoteScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (titleTextController.text.trim().isNotEmpty && noteTextController.text.trim().isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => WillPopScope(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
              onWillPop: () => Future.value(false),
            ),
          );
          if (widget.note == null) {
            await noteScreenController.addNote(
              Note(
                "null",
                titleTextController.text,
                noteTextController.text,
              ),
            );
          } else {
            await widget.id?.let((id) async {
              await noteScreenController.updateNote(
                id,
                Note(
                  id,
                  titleTextController.text,
                  noteTextController.text,
                ),
              );
            });
          }
          Navigator.of(context).pop();
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0.0),
                sliver: MultiSliver(
                  children: [
                    TextFormField(
                      controller: titleTextController,
                      maxLines: 1,
                      maxLength: 10,
                      style: const TextStyle(fontSize: 25.0),
                      decoration: const InputDecoration(
                        hintText: "Title",
                        border: InputBorder.none,
                        counter: SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: TextFormField(
                      controller: noteTextController,
                      style: const TextStyle(fontSize: 17.0),
                      keyboardType: TextInputType.multiline,
                      maxLines: 30,
                      decoration: const InputDecoration(
                        hintText: "Note",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
