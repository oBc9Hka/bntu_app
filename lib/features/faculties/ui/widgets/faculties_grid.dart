import 'package:bntu_app/features/specialties/ui/specialties_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/src/provider.dart';

import '../../../../core/provider/app_provider.dart';
import '../../provider/faculties_provider.dart';
import '../faculty_edit.dart';
import 'faculty_short_item.dart';

class FacultiesGridView extends StatelessWidget {
  const FacultiesGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap(var faculty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SpecialtiesScreen(
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

    final state = context.watch<FacultiesProvider>();
    final appState = context.watch<AppProvider>();

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
                user: appState.user,
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
