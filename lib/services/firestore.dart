import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
// Get collections of notes
  final CollectionReference book =
      FirebaseFirestore.instance.collection('bangla');
// CREATE: add a new note
  Future<void> addNotes(String questions, String answer, String category) {
    return book.add({
      'questions': questions,
      'answer': answer,
      'category': category,
      'timestamp': Timestamp.now(),
    });
  }

// READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream = book.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

// UPDATE: update notes given a doc id
  Future<void> updateNote(
      String docID, String questions, String answer, String category) {
    return book.doc(docID).update({
      'questions': questions,
      'answer': answer,
      'category': category,
      'timestamp': Timestamp.now(),
    });
  }
// DELETE: delete note given a doc id

  Future<void> deleteNote(String docID) {
    return book.doc(docID).delete();
  }
}
