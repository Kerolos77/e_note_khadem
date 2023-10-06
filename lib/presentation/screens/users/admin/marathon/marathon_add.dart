import 'package:e_note_khadem/data/firecase/firebase_reposatory.dart';
import 'package:e_note_khadem/utiles/id.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/marathon_model.dart';
import '../../../../widgets/global/toast.dart';
import 'marathon.dart';

class MarathonAdd extends StatefulWidget {
  final MarathonModel? note;

  const MarathonAdd({super.key, this.note});

  @override
  State<MarathonAdd> createState() => _MarathonAddState();
}

class _MarathonAddState extends State<MarathonAdd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Marathon(),
                  ));
            },
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.green,
            )),
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: ListView(
            children: [
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.grey, fontSize: 30),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 30)),
              ),
              TextField(
                controller: _contentController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type anything  here ',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_titleController.text != '' || _contentController.text != '') {
            firebaseReposatory
                .createMarathon(
                    id: ID.createId(),
                    title: _titleController.text,
                    content: _contentController.text,
                    modifiedTime: DateTime.now().toString())
                .then((value) {
              showToast(
                message: 'Done',
              );
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Marathon(),
                  ));
            }).catchError((error) {});
          }
        },
        elevation: 10,
        backgroundColor: Colors.green.shade300,
        child: const Icon(Icons.save),
      ),
    );
  }
}
