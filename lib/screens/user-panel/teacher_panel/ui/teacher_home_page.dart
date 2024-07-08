

import 'package:bounce/bounce.dart';

import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gla_certificate/screens/user-panel/teacher_panel/bloc/bloc/teacher_page_bloc.dart';
import 'package:gla_certificate/screens/user-panel/teacher_panel/ui/doc_open_page.dart';
import 'package:gla_certificate/utils/components/list_component.dart';
import 'package:gla_certificate/utils/enum.dart';


class THomePage extends StatefulWidget {
  const THomePage({super.key});

  @override
  State<THomePage> createState() => _THomePageState();
}

class _THomePageState extends State<THomePage> {
  TeacherPageBloc teacherPageBloc = TeacherPageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Home Page"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => TeacherPageBloc()..add(FetchStudentList())..add(FetchTeacherNameEvent()),
        child: BlocBuilder<TeacherPageBloc, TeacherPageState>(
            builder: (context, state) {
          if (state.teacherPageStatus == TeacherPageStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.teacherPageStatus == TeacherPageStatus.error) {
            return const Center(
              child: Text("Error Occured while fetching data !"),
            );
          }
          if (state.studentList.isEmpty) {
            return const Center(
              child: Text("NO data found "),
            );
          }

          return ListView.builder(
              itemCount: state.studentList.length,
              itemBuilder: (context, index) {
                final doc = state.studentList[index];
                return ListComponent(
                  child: ExpansionTileCard(
                    title: Text("Name ${doc.stName}"),
                    subtitle: Text("Emaii : ${doc.email}"),
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
                              Text("Phone ${doc.phone}"),
                              const SizedBox(
                                height: 10,
                              ),
                              ListComponent(
                                child: Bounce(
                                  child: const Center(
                                    child: Text("View Documents"),
                                  ),
                                  onTap: () {
                                    TeacherPageBloc()
                                        .add(FetchTeacherNameEvent());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DocumentOpenPageScreen(
                                                id: doc.id, tName: state.tName),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        }),
      )),
    );
  }
}
