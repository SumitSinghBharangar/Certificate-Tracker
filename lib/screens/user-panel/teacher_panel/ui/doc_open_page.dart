import 'package:bounce/bounce.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gla_certificate/screens/user-panel/teacher_panel/bloc/bloc/teacher_page_bloc.dart';
import 'package:gla_certificate/utils/colors/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/components/list_component.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/open_file.dart';

class DocumentOpenPageScreen extends StatefulWidget {
  final String id;
  final String tName;
  const DocumentOpenPageScreen(
      {super.key, required this.id, required this.tName});

  @override
  State<DocumentOpenPageScreen> createState() => _DocumentOpenPageScreenState();
}

class _DocumentOpenPageScreenState extends State<DocumentOpenPageScreen> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => TeacherPageBloc(),
          child: BlocBuilder<TeacherPageBloc, TeacherPageState>(
            builder: (context, state) {
              if (state.documentListPageStatus ==
                  DocumentListPageStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.documentListPageStatus ==
                  DocumentListPageStatus.error) {
                return const Center(
                  child: Text("Error Occured ! "),
                );
              }
              if (state.documentsList.isEmpty) {
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
                itemCount: state.documentsList.length,
                itemBuilder: ((context, index) {
                  final doc = state.documentsList[index];
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Start-date : $startdate"),
                                Text("End-Date :  $enddate"),
                                Text("Uploaded_at :  $uploaddate"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Chip(
                                        label: const Text("Open"),
                                        elevation: 11,
                                        backgroundColor: backgroundColor,
                                      ),
                                      onTap: () async {
                                        downloadAndOpenPdf(doc.fileUrl);
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Bounce(
                                          child: const Chip(
                                            label: Text("Approve"),
                                            padding: EdgeInsets.all(8),
                                            backgroundColor: Colors.green,
                                          ),
                                          onTap: () {
                                            TeacherPageBloc()
                                                .add(UpdateApproveStatusEvent(
                                              id: widget.id,
                                              updateData: {
                                                'status': 'Approved',
                                                "approved_by": widget.tName
                                              },
                                            ));
                                          },
                                        ),
                                        Bounce(
                                          child: const Chip(
                                            elevation: 11,
                                            padding: EdgeInsets.all(8),
                                            label: Text("Reject"),
                                            backgroundColor: Colors.red,
                                          ),
                                          onTap: () {
                                            TeacherPageBloc().add(
                                              UpdateApproveStatusEvent(
                                                id: widget.id,
                                                updateData: {
                                                  'status': 'Rejected',
                                                  "approved_by": widget.tName
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
