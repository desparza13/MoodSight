import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodsight/mood_graph_page.dart';
import 'package:moodsight/themes/bloc/theme_bloc.dart';
import 'package:moodsight/themes/app_themes.dart';
import 'package:moodsight/services/quote_api.dart';
import 'package:moodsight/log_entry_page.dart';
import 'package:moodsight/view_moods_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<String> quote;

  @override
  void initState() {
    super.initState();
    quote = fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodSight'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_2_sharp),
            onPressed: () {
              if (BlocProvider.of<ThemeBloc>(context).state.themeData == appThemeData[AppTheme.customLight]) {
                BlocProvider.of<ThemeBloc>(context).add(const ThemeChangedEvent(theme: AppTheme.customDark));
              } else {
                BlocProvider.of<ThemeBloc>(context).add(const ThemeChangedEvent(theme: AppTheme.customLight));
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              height: screenHeight / 6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              //Bienvenida
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/images/woman_journaling.png', fit: BoxFit.fitHeight),
                  ),
                  const SizedBox(width: 20),
                  Expanded(child: Text('Welcome to MoodSight!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary))),
                ],
              ),
            ),
            const SizedBox(height: 40),
            //Frase
            FutureBuilder<String>(
              future: quote,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('Failed to load quote');
                }
                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data ?? '',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.error),
                            overflow: TextOverflow.visible,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    //Cargar nueva frase
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quote = fetchQuote();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            //New entry
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogEntryPage()),
                      );
                    },
                    child: const Text('Log new entry'))),
                  const SizedBox(width: 20),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/images/journal.png', fit: BoxFit.fitWidth),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //Historial
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/images/calendar.png', fit: BoxFit.fitWidth),
                  ),
                  const SizedBox(width: 20),
                  Expanded(child: ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewMoodsPage()),
                      );
                    }, child: const Text('View moods history'))),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //Gráfica
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MoodGraph()),
                      );
                    }, child: const Text('Mood graph for the month'))),
                  const SizedBox(width: 20),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/images/graph.png', fit: BoxFit.fitWidth),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
