import 'package:get/get.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/firebase_service.dart';

class HomeScreenController extends GetxController {
  final notes = List<Note>.empty().obs;

  final fetchingNotes = false.obs;

  Future<void> fetchNotes() async {
    fetchingNotes(true);
    final notes = await Get.find<FirebaseService>().fetchNotes();
    fetchingNotes(false);
    this.notes(notes);
  }

  void listenToNotes() async {
    await for (final x in Get.find<FirebaseService>().listenToNotes()) {
      notes(x);
    }
  }
}
