import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gla_certificate/screens/admin-panel/teacher_list_page/bloc/bloc/teacher_list_page_bloc.dart';
import 'package:gla_certificate/utils/components/list_component.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:gla_certificate/utils/utils.dart';
import 'package:lottie/lottie.dart';

class TeacherListPageScreen extends StatefulWidget {
  const TeacherListPageScreen({super.key});

  @override
  State<TeacherListPageScreen> createState() => _TeacherListPageScreenState();
}

class _TeacherListPageScreenState extends State<TeacherListPageScreen> {
  TeacherListPageBloc teacherListPageBloc = TeacherListPageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher List Page Screen"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              TeacherListPageBloc()..add(FetchTeacherListEvent()),
          child: BlocBuilder<TeacherListPageBloc, TeacherListPageState>(
              builder: (context, state) {
            if (state.teacherListPageStatus == TeacherListPageStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.teacherListPageStatus == TeacherListPageStatus.error) {
              return const Center(
                child: Text("Error Occur while fetching the data !"),
              );
            }
            if (state is EmptyTeacherListState || state.teacherList.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.,
                  // ),
                  Lottie.asset("assets/lotties/error404.json"),
                  const Text("No data found ",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.bold))
                ],
              );
            }
            return ListView.builder(
                itemCount: state.teacherList.length,
                itemBuilder: (context, index) {
                  final document = state.teacherList[index];
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
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone ${document.phone}"),
                                IconButton(
                                    onPressed: () async {
                                      teacherListPageBloc.add(
                                          DeleteTeacherEvent(id: document.id));
                                      Utils.snakbar(
                                          "deleted successfully", context);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}
