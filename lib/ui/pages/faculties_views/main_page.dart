import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/speciality_views/faculty_info.dart';
import 'package:bntu_app/ui/widgets/faculty_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'faculty_add.dart';
import 'faculty_edit.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Список факультетов'),
            elevation: 3,
            actions: [
              state.user != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacultyAdd(),
                                ),
                              );
                            },
                            icon: Icon(Icons.add)),
                        IconButton(
                            onPressed: () {
                              state.initFaculties();
                            },
                            icon: Icon(Icons.refresh)),
                      ],
                    )
                  : Container()
            ],
          ),
          body: (!state.isFacultiesLoaded)
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: ListView.builder(
                      itemCount: state.faculties.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: FacultyItem(
                            shortName:
                                state.faculties[index].shortName.toString(),
                            name: state.faculties[index].name.toString(),
                            user: state.user,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacultyPage(
                                    faculty: state.faculties[index],
                                  ),
                                ),
                              );
                            },
                            onEditPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacultyEdit(
                                    faculty: state.faculties[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}
