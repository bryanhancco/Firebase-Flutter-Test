import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/users.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_firebase/models.dart';
import 'package:flutter_firebase/firebase_operations.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}
class _CalendarScreenState extends State<CalendarScreen> {
  List<Curso> cursos = <Curso>[];
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: readCourses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data?.forEach((data) {
              cursos.add(Curso.fromJson(data));
            });
            
            return Scaffold(
              body: SfCalendar(
                view: CalendarView.workWeek,
                initialSelectedDate: DateTime(2023,11,10, 12),
                dataSource:  CourseDataSource(cursos),
                firstDayOfWeek: 1,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  startHour: 7,
                  endHour: 21,
                  nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                ),
              ),
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: 
             () {
              Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return UserScreen();
          },
        ));
            },
      ),
    );
  }
}