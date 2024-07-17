import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/presentation/components/selector.dart';
import 'package:we_chat/presentation/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  Uint8List? _image;

  Future<void> editField(String field) async {
    String newData = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text("Edit $field"),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter a new $field",
          ),
          onChanged: (value) {
            newData = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(newData),
              child: const Text('Save')),
        ],
      ),
    );
    if (newData.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({field: newData});
    }
  }

  void selectImg() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 216, 216),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Profile Page",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // const Icon(
                  //   Icons.person,
                  //   size: 72,
                  // ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYK8aNyMiO8wxayYoFaPN5xKMINdBjL8VWJw&s"),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 225,
                        child: IconButton(
                          onPressed: selectImg,
                          icon: const Icon(Icons.add_a_photo_rounded),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[900], fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 25.0,
                    ),
                    child: Text(
                      'Description',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                  TextBoxUpd(
                    text: userData['username'],
                    sectionName: 'username',
                    onPressed: () => editField('username'),
                  ),
                  TextBoxUpd(
                    text: userData['bio'],
                    sectionName: 'bio',
                    onPressed: () => editField('bio'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      // body: ListView(
      //   children: [
      //     const SizedBox(
      //       height: 50,
      //     ),
      //     const Icon(
      //       Icons.person,
      //       size: 72,
      //     ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     Text(
      //       currentUser.email!,
      //       textAlign: TextAlign.center,
      //       style:
      //           TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w900),
      //     ),
      //     const SizedBox(
      //       height: 50,
      //     ),
      //     const Padding(
      //       padding: EdgeInsets.only(
      //         left: 25.0,
      //       ),
      //       child: Text(
      //         'Description',
      //         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      //       ),
      //     ),
      //     TextBoxUpd(
      //       text: 'SAKOVICH',
      //       sectionName: 'username',
      //       onPressed: () => editField('username'),
      //     ),

      //     TextBoxUpd(
      //       text: 'empty bio',
      //       sectionName: 'bio',
      //       onPressed: () => editField('bio'),
      //     ),
      //   ],
      // ),
    );
  }
}
