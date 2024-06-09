import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:gla_certificate/repositories/fetchdocument_repository.dart';
import 'package:gla_certificate/routes/route_name.dart';
import 'package:gla_certificate/utils/utils.dart';
import 'package:lottie/lottie.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  late Future<List<DocumentSnapshot>> _documentsFuture;
  // FetchDocumentRepository fetchDocumentRepository = FetchDocumentRepository();
  FetchDocumentRepository fetchDocumentRepository = FetchDocumentRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _documentsFuture = fetchDocumentRepository.fetchDocuments();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page "),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await _auth.signOut().then((value) {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.loginScreen);
                  Utils.snakbar("Succesfully logout", context);
                });
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.1,
            ),
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: _documentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Lottie.asset("assets/lotties/error404.json"),
                        Center(
                            child: Text(
                          'No documents found !',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                      ],
                    );
                  }
                  List<DocumentSnapshot> documents = snapshot.data!;
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        var document = documents[index];
                        var fileName = document['file_name'];
                        var fileUrl = document['file_url'];

                        return Card(
                          elevation: 11,
                          child: ListTile(
                            title: Text(fileName),
                            subtitle: Text(fileUrl),
                            onTap: () {
                              // Open the document URL in a web view or browser
                              // _openDocument(fileUrl);
                            },
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.fileUploadPage);
        },
        child: Lottie.asset("assets/lotties/addfile.json"),
      ),
    );
  }
}
