import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes/models/note.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  final String _collectionPath = 'notes';

  Future<void> updateNote(String id, Note note) async {
    final user = Get.find<User?>();
    if (user == null) throw Exception();
    final db = Get.find<FirebaseFirestore>();
    db.collection(_collectionPath).doc(user.uid).update({id: note.toJson()});
  }

  Future<void> createNote(Note note) async {
    final user = Get.find<User?>();
    if (user == null) throw Exception();
    final db = Get.find<FirebaseFirestore>();
    final noteId = const Uuid().v4();
    db.collection(_collectionPath).doc(user.uid).set(
      {noteId: note.copyWith(id: noteId).toJson()},
      SetOptions(merge: true),
    );
  }

  Future<void> deleteNote(String id) async {
    final user = Get.find<User?>();
    if (user == null) throw Exception();
    final db = Get.find<FirebaseFirestore>();

    await db.collection(_collectionPath).doc(user.uid).update({id: FieldValue.delete()});
  }

  Future<List<Note>> fetchNotes() async {
    final user = Get.find<User?>();
    if (user == null) throw Exception();
    final db = Get.find<FirebaseFirestore>();

    final snaps = await db.collection(_collectionPath).doc(user.uid).get();
    final notes = List<Note>.empty(growable: true);
    snaps.data()?.values.forEach((e) {
      notes.add(Note.fromJson(e));
    });
    return notes;
  }

  Stream<List<Note>> listenToNotes() async* {
    final user = Get.find<User?>();
    if (user == null) throw Exception();
    final db = Get.find<FirebaseFirestore>();

    await for (final x in db.collection(_collectionPath).doc(user.uid).snapshots()) {
      final notes = List<Note>.empty(growable: true);
      x.data()?.values.forEach((e) {
        notes.add(Note.fromJson(e));
      });
      yield notes;
    }
  }
}
