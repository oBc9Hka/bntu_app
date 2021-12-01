import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/faculties_views/faculty_edit.dart';
import 'package:bntu_app/ui/pages/speciality_views/faculty_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/src/provider.dart';

import 'faculty_short_item.dart';

class FacultiesGridView extends StatelessWidget {
  const FacultiesGridView({Key? key}) : super(key: key);

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

    void _onEditPressed(var faculty) {
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

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 3),
      itemCount: state.faculties.length,
      itemBuilder: (context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 200),
            columnCount: 2,
            child: FadeInAnimation(
              child: FacultyShortItem(
                shortName: state.faculties[index].shortName.toString(),
                user: state.user,
                onTap: () {
                  _onTap(state.faculties[index]);
                },
                onEditPressed: () {
                  _onEditPressed(state.faculties[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}