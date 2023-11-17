import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

Future createCourse({required Curso curso}) async {
  final course = FirebaseFirestore.instance.collection('courses');
  await course.add(curso.toMap());
}

Future<List> readCourses() async {
  List cursos = [];
  CollectionReference collectionReferenceCursos = FirebaseFirestore.instance.collection('courses');
  QuerySnapshot queryCursos = await collectionReferenceCursos.get();
  queryCursos.docs.forEach((doc) {
    cursos.add(doc.data());
  });
  //cursos = queryCursos.docs.map((doc) => Curso.fromJson(doc.data() as Map<String, dynamic>)).toList();
  return cursos;
}
   
  