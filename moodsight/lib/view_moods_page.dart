import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodsight/blocs/entry_form_bloc.dart';
import 'package:moodsight/themes/app_themes.dart';
import 'package:moodsight/themes/bloc/theme_bloc.dart';

class ViewMoodsPage extends StatelessWidget {
  const ViewMoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood history'),
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
      body: BlocBuilder<EntryFormBloc, EntryFormState>(
        builder: (context, state) {
          if (state is EntryFormSaved) {
            final entryHistory = state.entryHistory;

            return ListView.builder(
              itemCount: entryHistory.length,
              itemBuilder: (context, index) {
                final entry = entryHistory[index];

                return Theme(
                  data: ThemeData.from(colorScheme: Theme.of(context).colorScheme), 
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary, 
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2), 
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen a la izquierda
                        Image.asset(
                          entry.selectedMood ?? '/assets/images/neutral.png',
                          width: 80.0,
                          height: 80.0,
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gratitude:',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                entry.gratitude ?? 'No gratitude provided',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Notas del día
                              const Text(
                                'Notes:',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                entry.notes ?? 'No notes provided',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No mood history available.'),
            );
          }
        },
      ),
    );
  }
}
