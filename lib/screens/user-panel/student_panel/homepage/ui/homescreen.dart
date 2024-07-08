import 'package:firebase_auth/firebase_auth.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gla_certificate/routes/route_name.dart';
import 'package:gla_certificate/utils/colors/app_colors.dart';
import 'package:gla_certificate/utils/components/list_component.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:gla_certificate/utils/open_file.dart';
import 'package:gla_certificate/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../block/homepage_bloc.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  // FetchDocumentRepository fetchDocumentRepository = FetchDocumentRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final HomePageBloc homePageBloc = HomePageBloc();

  @override
  void initState() {
    HomePageBloc().add(FetchDocuments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    // var w = MediaQuery.of(context).size.width;
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
          child: BlocProvider(
              create: (context) => HomePageBloc()..add(FetchDocuments()),
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  if (state.homePageStatus == HomePageStatus.loading) {
                    return Expanded(child: Container());
                  }
                  if (state.homePageStatus == HomePageStatus.error) {
                    return Center(
                      child: Text("Error Occured ! "),
                    );
                  }
                  if (state.documents.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: h * 0.2,
                        ),
                        Lottie.asset("assets/lotties/error404.json"),
                      ],
                    );
                  }
                  return ListView.builder(
                      itemCount: state.documents.length,
                      itemBuilder: ((context, index) {
                        final doc = state.documents[index];
                        DateTime sdate = doc.startDate;
                        String startdate =
                            DateFormat('yyyy-MM-dd – kk:mm').format(sdate);
                        DateTime edate = doc.endDate;
                        String enddate =
                            DateFormat('yyyy-MM-dd – kk:mm').format(edate);
                        DateTime udate = doc.uploadedAt;
                        String uploaddate =
                            DateFormat('yyyy-MM-dd – kk:mm').format(udate);
                        return ListComponent(
                          child: ExpansionTileCard(
                            elevation: 110,
                            title: Text("Document ${doc.fileName}"),
                            subtitle: Text("Type : ${doc.type}"),
                            children: [
                              const Divider(
                                thickness: 0.5,
                                height: 1,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Start-date : $startdate"),
                                      Text("End-Date :  $enddate"),
                                      Text("Uploaded_at :  $uploaddate"),
                                      Visibility(
                                        visible: doc.approvedBy != "None",
                                        child: doc.approvedBy == "Approved"
                                            ? Text(
                                                "Approved by : ${doc.approvedBy}")
                                            : Text(
                                                "Reject by : ${doc.approvedBy}"),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Status : "),
                                              Chip(
                                                elevation: 11,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                label: Text("${doc.status}"),
                                                backgroundColor: doc.status ==
                                                        "pending"
                                                    ? Colors.yellow
                                                    : doc.status == "Approved"
                                                        ? Colors.green
                                                        : Colors.red,
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            child: Chip(
                                              label: const Text("Open"),
                                              elevation: 11,
                                              backgroundColor: backgroundColor,
                                            ),
                                            onTap: () async {
                                              downloadAndOpenPdf(doc.fileUrl);
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }));
                },
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.fileUploadPage);
        },
        child: Lottie.asset("assets/lotties/addfile.json"),
      ),
    );
  }
}
