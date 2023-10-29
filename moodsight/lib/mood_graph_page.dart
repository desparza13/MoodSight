import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodsight/blocs/entry_form_bloc.dart';
import 'package:moodsight/themes/app_themes.dart';
import 'package:moodsight/themes/bloc/theme_bloc.dart';

class MoodGraph extends StatelessWidget {
  const MoodGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Graph'),
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

            final moodCounts = <String, int>{};

            for (final entry in entryHistory) {
              // Obtener estado de ánimo de la ruta de la imagen
              final moodImagePath = entry.selectedMood ?? 'assets/images/neutral.png';
              final moodName = moodImagePath.split('/').last.replaceAll('.png', '');

              // Contar cuantos de cada mood hay
              moodCounts[moodName] = (moodCounts[moodName] ?? 0) + 1;
            }

            final totalEntries = moodCounts.values.fold(0, (prev, count) => prev + count);

            final data = moodCounts.entries.map((entry) {
              final moodColor = _getMoodColor(context, entry.key);
              final percentage = (entry.value / totalEntries * 100).toStringAsFixed(2);
              final legendLabel = '$percentage%';
              return PieChartSectionData(
                color: moodColor,
                title: '',
                value: entry.value.toDouble(),
                radius: 100, // Radio de la sección
                titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: moodColor,
                ),
                badgeWidget: Text(
                  legendLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                badgePositionPercentageOffset: .85,
              );
            }).toList();

            return Center( 
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 80.0),
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: PieChart(
                        PieChartData(
                          sections: data,
                          sectionsSpace: 8.0,
                          centerSpaceRadius: 30.0,
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildLegend(context, 'Happy', _getMoodColor(context, 'happy')),
                        _buildLegend(context, 'Neutral', _getMoodColor(context, 'neutral')),
                        _buildLegend(context, 'Angry', _getMoodColor(context, 'angry')),
                        _buildLegend(context, 'Sad', _getMoodColor(context, 'sad')),
                        _buildLegend(context, 'Excited', _getMoodColor(context, 'excited')),
                      ],
                    ),
                  ],
                ),
              ),
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

  Color _getMoodColor(BuildContext context, String moodName) {
    // Colores por estado de animo
    switch (moodName) {
      case 'happy':
        return Theme.of(context).colorScheme.primary;
      case 'neutral':
        return Theme.of(context).colorScheme.secondary;
      case 'angry':
        return Theme.of(context).colorScheme.error;
      case 'sad':
        return Color(0xFFC4D5FF);
      case 'excited':
        return Color(0xFFF80086);
      default:
        return Colors.grey; 
    }
  }

  //Construir la leyenda
  Widget _buildLegend(BuildContext context, String label, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              color: color,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
