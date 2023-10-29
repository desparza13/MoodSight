import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodsight/blocs/entry_form_bloc.dart';

class LogEntryPage extends StatefulWidget {
  const LogEntryPage({super.key});

  @override
  LogEntryPageState createState() => LogEntryPageState();
}

class LogEntryPageState extends State<LogEntryPage> {
  String? selectedMood;
  final List<String> moods = [
    'assets/images/excited.png',
    'assets/images/happy.png',
    'assets/images/neutral.png',
    'assets/images/sad.png',
    'assets/images/angry.png',
  ];

  TextEditingController notesController = TextEditingController();
  TextEditingController gratitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Today\'s Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('How did you feel today?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMood = moods[index];
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                //Poner el color del marquito cuando uno está seleccionado
                                color: selectedMood == moods[index] ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(moods[index], fit: BoxFit.contain, width: 80),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            getMoodText(index),
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: notesController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Notes about your day...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: gratitudeController,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Something you are grateful for today...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/log_entry.png',
                height: 150,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Verificar que todos los campos estén llenos
                  if (selectedMood == null || notesController.text.isEmpty || gratitudeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields.'),
                      ),
                    );
                    return;
                  }

                  // Obtén una instancia del EntryFormBloc
                  final entryFormBloc = BlocProvider.of<EntryFormBloc>(context);

                  // Dispara el evento SaveEntryEvent con los datos del formulario
                  entryFormBloc.add(SaveEntryEvent(
                    selectedMood: selectedMood,
                    notes: notesController.text,
                    gratitude: gratitudeController.text,
                  ));

                  // Cerrar la página actual y volver a la página de inicio
                  Navigator.of(context).pop();

                  // Mostrar la Snackbar de que se guardó
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Entry saved successfully!'),
                    ),
                  );
                },
                child: const Text('Save Entry'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMoodText(int index) {
    switch (index) {
      case 0:
        return 'Excited';
      case 1:
        return 'Happy';
      case 2:
        return 'Neutral';
      case 3:
        return 'Sad';
      case 4:
        return 'Angry';
      default:
        return '';
    }
  }

}
