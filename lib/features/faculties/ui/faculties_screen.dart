import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/app_provider.dart';
import '../provider/faculties_provider.dart';
import 'faculty_add.dart';
import 'widgets/faculties_grid.dart';
import 'widgets/faculties_list.dart';
import 'widgets/help_card.dart';

class FacultiesScreen extends StatefulWidget {
  const FacultiesScreen({Key? key}) : super(key: key);

  @override
  _FacultiesScreenState createState() => _FacultiesScreenState();
}

class _FacultiesScreenState extends State<FacultiesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void didChangeDependencies() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 350),
        value: context.watch<FacultiesProvider>().isList ? 0 : 1);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppProvider>();
    return Consumer<FacultiesProvider>(
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
              appState.user != null
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
          body: (state.isLoading)
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
