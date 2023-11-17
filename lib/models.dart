import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class Curso {
  final String CurNom;
  final String CurNomCor;
  final bool isRequired;
  final int CurDia;
  final int CurHorIni;
  final int CurMinIni;
  final int CurHorFin;
  final int CurMinFin;

  Curso({
    required this.CurNom,
    required this.CurNomCor,
    required this.isRequired,
    required this.CurDia,
    required this.CurHorIni,
    required this.CurMinIni,
    required this.CurHorFin,
    required this.CurMinFin,
  });

  Curso.empty(this.CurNom, this.CurNomCor, this.isRequired, this.CurDia, this.CurHorIni, this.CurMinIni, this.CurHorFin, this.CurMinFin);

  Map<String, dynamic> toMap() {
    return {
      'CurNom': CurNom,
      'CurNomCor': CurNomCor,
      'CurReq': isRequired,
      'CurDia': CurDia,
      'CurHorIni': CurHorIni,
      'CurMinIni': CurMinIni,
      'CurHorFin': CurHorFin,
      'CurMinFin': CurMinFin,
    };
  }

  static Curso fromJson(Map<String, dynamic> json) => Curso(
    CurNom: json['CurNom'], 
    CurNomCor: json['CurNomCor'],
    isRequired: json['CurReq'],
    CurDia: (json['CurDia'] as int),
    CurHorIni: (json['CurHorIni'] as int),
    CurMinIni: (json['CurMinIni'] as int),
    CurHorFin: (json['CurHorFin'] as int),
    CurMinFin: (json['CurMinFin'] as int),
  );
}
class CourseDataSource extends CalendarDataSource {
  var today;
  CourseDataSource(List<Curso> source) {
    appointments = source;
    today = DateTime.now();
  }

  @override
  DateTime getStartTime(int index) {
    int day = appointments![index].CurDia;
    int hourIni = appointments![index].CurHorIni;
    int minIni = appointments![index].CurMinIni;
    final date = DateTime(today.year, today.month, day, hourIni, minIni, 0);
    return date;
  }

  @override
  DateTime getEndTime(int index) {
    int day = appointments![index].CurDia;
    int hourFin = appointments![index].CurHorFin;
    int minFin = appointments![index].CurMinFin;
    final date = DateTime(today.year, today.month, day, hourFin, minFin, 0);
    return date;
  }

  @override
  String getSubject(int index) {
    return appointments![index].CurNom;
  }

  @override
  Color getColor(int index) {
    return const Color.fromARGB(255, 54, 109, 172);
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
