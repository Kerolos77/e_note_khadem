import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../data/firecase/firebase_reposatory.dart';
import '../../../../../data/local/cache_helper.dart';
import '../../../../../data/models/marathon_model.dart';
import '../../../../widgets/global/toast.dart';
import '../../../regisation_screen.dart';
import 'marathon_add.dart';

class Marathon extends StatefulWidget {
  const Marathon({Key? key}) : super(key: key);

  @override
  State<Marathon> createState() => _MarathonState();
}

class _MarathonState extends State<Marathon> {
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  List<MarathonModel> filteredNotoes = [];
  bool sorted = false;
  List<MarathonModel> sampleNotes = [];

  @override
  void initState() {
    super.initState();
    getMarathonData();
  }

  List<MarathonModel> sortNotesByModifiedTime(List<MarathonModel> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }
    sorted = !sorted;
    return notes;
  }

  void onSearchTextChange(String searchText) {
    setState(() {
      filteredNotoes = sampleNotes
          .where((note) =>
      note.content.toLowerCase().contains(searchText.toLowerCase()) ||
          note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void deleteNote(int index) {
    setState(() {
      MarathonModel note = filteredNotoes[index];
      sampleNotes.remove(note);
      filteredNotoes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          onChanged: onSearchTextChange,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              hintText: "Search ...",
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: Colors.transparent),
              )),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  filteredNotoes = sortNotesByModifiedTime(filteredNotoes);
                });
              },
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.sort,
                color: Colors.green,
              )),
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: Column(
        children: [

          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 30),
                  itemCount: filteredNotoes.length,
                  itemBuilder: (context, index) {
                    return Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        color: Colors.greenAccent.shade100,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            title: RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: '${filteredNotoes[index].title} \n',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: filteredNotoes[index].content,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          height: 1.5),
                                    )
                                  ]),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                filteredNotoes[index].modifiedTime,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MarathonAdd(),
              ));
        },
        elevation: 10,
        backgroundColor: Colors.green.shade300,
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    showToast(
      message: 'Log out Successfully',
    );
    CacheHelper.removeData(key: "user");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Registration(),
        ));
  }

  void getMarathonData() {
    MarathonModel marathonModel;
    sampleNotes = [];
    firebaseReposatory.getMarathonData().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        marathonModel = MarathonModel(
            value.docs[i].data()['id'],
            value.docs[i].data()['title'],
            value.docs[i].data()['content'],
            value.docs[i].data()['modifiedTime']);
        sampleNotes.add(marathonModel);
      }
      filteredNotoes = sampleNotes;
      setState(() {});
    });
  }
}
