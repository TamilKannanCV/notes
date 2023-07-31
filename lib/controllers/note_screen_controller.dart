import 'package:get/get.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/firebase_service.dart';

class NoteScreenController extends GetxController {
  Future<void> addNote(Note note) async {
    final firebaseService = Get.find<FirebaseService>();
    await firebaseService.createNote(note);
  }

  Future<void> updateNote(String id, Note note) async {
    final firebaseService = Get.find<FirebaseService>();
    await firebaseService.updateNote(id, note);
  }
}
