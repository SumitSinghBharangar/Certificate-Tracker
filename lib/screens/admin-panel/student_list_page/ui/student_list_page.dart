import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/components/list_component.dart';
import '../../../../utils/utils.dart';
import '../bloc/bloc/student_list_page_bloc.dart';

class StudentListPageScreen extends StatefulWidget {
  const StudentListPageScreen({super.key});

  @override
  State<StudentListPageScreen> createState() => _StudentListPageScreenState();
}

class _StudentListPageScreenState extends State<StudentListPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student List Page "),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (create) =>
              StudentListPageBloc()..add(FetchStudentListEvent()),
          child: BlocBuilder<StudentListPageBloc, StudentListPageState>(
            builder: (context, state) {
              if (state.studentListPageStatus ==
                  StudentListPageStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.studentListPageStatus == StudentListPageStatus.error) {
                return const Center(
                  child: Text("Errror occur while fetching the the data"),
                );
              }
              if (state is EmptyStudentListState || state.studentList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/lotties/error404.json"),
                    const Text(
                      "No data found ",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              }
              return ListView.builder(
                itemCount: state.studentList.length,
                itemBuilder: (context, index) {
                  final document = state.studentList[index];
                  return ListComponent(
                    child: ExpansionTileCard(
                      title: Text("Name ${document.stName}"),
                      subtitle: Text("Emaii : ${document.email}"),
                      children: [
                        const Divider(
                          thickness: 0.5,
                          height: 1,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Phone ${document.phone}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    StudentListPageBloc().add(
                                      DeleteStudentEvent(id: document.id),
                                    );
                                    Utils.snakbar(
                                        "deleted successfully", context);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
