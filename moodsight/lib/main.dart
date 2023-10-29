import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodsight/themes/bloc/theme_bloc.dart';
import 'package:moodsight/blocs/entry_form_bloc.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BLoC provider para el cambio de tema
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        // BLoC provider para EntryFormBloc
        BlocProvider(
          create: (context) => EntryFormBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'MoodSight',
            theme: state.themeData,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
