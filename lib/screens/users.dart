import 'package:flutter/material.dart';
import 'package:flutter_firebase/models.dart';
import 'package:flutter_firebase/firebase_operations.dart';
import 'package:intl/intl.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final controllerCourseName = TextEditingController();
  final controllerCourseShortName = TextEditingController();
  bool isRequired = false;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeIni = TimeOfDay.now();
  TimeOfDay _timeFin = TimeOfDay.now();

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Fecha',
            ),
            TextButton(
              child: const Text('Seleccionar'),
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );

                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
      ],
    );
  }

  Widget buildInitialTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Inicio",
            ),
            TextButton(
              child: const Text('Seleccionar'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  initialTime: _timeIni,
                  context: context,
                );
                setState(() {
                  if (timeOfDay != null) {
                    _timeIni = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text(_timeIni.format(context)),
      ],
    );
  }
  Widget buildFinalTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Fin",
            ),
            TextButton(
              child: const Text('Seleccionar'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  initialTime: _timeFin,
                  context: context,
                );
                setState(() {
                  if (timeOfDay != null) {
                    _timeFin = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text(_timeFin.format(context)),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nombre del curso"),
                TextField(
                  controller: controllerCourseName,
                ),
                const SizedBox(height: 15,),
                const Text("Nombre corto del curso"),
                TextField(
                  controller: controllerCourseShortName,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Es requerido?"),
                    Checkbox(
                      value: isRequired,
                      onChanged: (value) {
                        setState(() {
                          isRequired = !isRequired;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dia"),
                    buildDateField(context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Hora de Inicio"),
                    buildInitialTimeField(context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Hora de Finalizacion"),
                    buildFinalTimeField(context),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            final courseName = controllerCourseName.text;
            final shortName = controllerCourseShortName.text;
            final day = _dueDate.day;
            final hourIni = _timeIni.hour;
            final minIni = _timeIni.minute;
            final hourFin = _timeFin.hour;
            final minFin = _timeFin.minute;

            final course = Curso(CurNom: courseName, CurNomCor: shortName, isRequired: isRequired, CurDia: day, CurHorIni: hourIni, CurMinIni: minIni, CurHorFin: hourFin, CurMinFin: minFin);
            createCourse(curso: course);
          }),
      ),
    );
  }
}