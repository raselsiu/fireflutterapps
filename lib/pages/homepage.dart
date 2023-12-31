import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireapps/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FireStoreService
  FireStoreService fireStoreService = FireStoreService();

  // TextController
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descTextController = TextEditingController();
  final TextEditingController _categoryTextController = TextEditingController();

  // adding a dialog box to add a note
  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 300,
          child: Column(
            children: [
              TextField(
                controller: _titleTextController,
                decoration: const InputDecoration(
                  hintText: 'Questions',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _categoryTextController,
                decoration: const InputDecoration(
                  hintText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                maxLines: 4,
                controller: _descTextController,
                decoration: const InputDecoration(
                  hintText: 'Answer',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => {
              if (docID == null)
                {
                  fireStoreService.addNotes(
                    _titleTextController.text,
                    _descTextController.text,
                    _categoryTextController.text,
                  ),
                }
              else
                {
                  fireStoreService.updateNote(
                    docID,
                    _titleTextController.text,
                    _descTextController.text,
                    _categoryTextController.text,
                  )
                },
              _titleTextController.clear(),
              _descTextController.clear(),
              _categoryTextController.clear(),
              Navigator.pop(context),
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('bangla').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.ac_unit,
          color: Colors.white,
        ),
        title: const Text(
          'Firebase Testing',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Data Test for category wise view

          // FirebaseFirestore.instance
          //     .collection('bangla')
          //     .where('category', isEqualTo: 'mango')
          //     .get()
          //     .then((QuerySnapshot querySnapshot) {
          //   final count = querySnapshot.size;
          //   if (count == 0) {
          //     print('No data found!');
          //   }
          //   querySnapshot.docs.forEach((doc) {
          //     print(doc['category']);
          //   });
          // });

          // Dummy

          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                backgroundColor: Colors.purple,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  String docID = document.id;

                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return Card(
                    color: Colors.indigo,
                    elevation: 5,
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                        title: Text(
                          data['questions'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          data['answer'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                openNoteBox(docID: docID);
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                fireStoreService.deleteNote(docID);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        )),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openNoteBox();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
