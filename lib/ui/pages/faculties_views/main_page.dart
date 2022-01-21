import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/widgets/faculties/faculties_grid.dart';
import 'package:bntu_app/ui/widgets/faculties/faculties_list.dart';
import 'package:bntu_app/ui/widgets/faculties/help_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'faculty_add.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void didChangeDependencies() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 350),
        value: context.watch<AppProvider>().isList ? 0 : 1);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Список факультетов'),
            elevation: 3,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    state.isList = !state.isList;
                    !state.isList
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
                icon: AnimatedIcon(
                  icon: AnimatedIcons.list_view,
                  progress: _animationController,
                ),
              ),
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
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: state.isList
                            ? FacultiesListView()
                            : FacultiesGridView(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 20,
                        ),
                        child: HelpCard(),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
