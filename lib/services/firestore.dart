import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
// Get collections of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');
// CREATE: add a new note
  Future<void> addNotes(String title, String description, String category) {
    return notes.add({
      'title': title,
      'description': description,
      'category': category,
      'timestamp': Timestamp.now(),
    });
  }

// READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

// UPDATE: update notes given a doc id
  Future<void> updateNote(
      String docID, String title, String description, String category) {
    return notes.doc(docID).update({
      'title': title,
      'description': description,
      'category': category,
      'timestamp': Timestamp.now(),
    });
  }
// DELETE: delete note given a doc id

  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
