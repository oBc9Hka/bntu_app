import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/faculties_views/faculty_edit.dart';
import 'package:bntu_app/ui/pages/speciality_views/faculty_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'faculty_item.dart';

class FacultiesListView extends StatelessWidget {
  const FacultiesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap(var faculty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FacultyPage(
            faculty: faculty,
          ),
        ),
      );
    }
    void _onEditPressed(var faculty){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FacultyEdit(
            faculty: faculty,
          ),
        ),
      );
    }
    var state = context.watch<AppProvider>();

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ...state.faculties.map(
              (faculty) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: 10),
              child: FacultyItem(
                shortName: faculty.shortName.toString(),
                name: faculty.name.toString(),
                user: state.user,
                onTap: () {
                  _onTap(faculty);
                },
                onEditPressed: () {
                  _onEditPressed(faculty);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
