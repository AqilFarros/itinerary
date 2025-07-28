part of 'firebase.dart';

class RoutineService {
  final firestore = FirebaseFirestore.instance;
  String userId = AuthService().auth.currentUser!.uid;

  Stream<QuerySnapshot>? getRoutine() {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('routines')
        .orderBy('start')
        .orderBy('end')
        .snapshots();
  }

  Future<void> addRoutine({
    required String name,
    required String type,
    required String start,
    required String end,
  }) async {
    await firestore.collection('users').doc(userId).collection('routines').add({
      "name": name,
      "type": type,
      "start": Helper.convertToMinute(start),
      "end": Helper.convertToMinute(end),
    });
  }

  Future<void> deleteRoutine(String id) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('routines')
        .doc(id)
        .delete();
  }
}
