part of 'firebase.dart';

class AgendaService {
  final firestore = FirebaseFirestore.instance;
  final userId = AuthService().auth.currentUser!.uid;

  Stream<QuerySnapshot> getAgenda() {
    return firestore
        .collectionGroup('agendas')
        .where('userId', isEqualTo: userId)
        .orderBy('date')
        .snapshots();
  }

  Future<void> addAgenda({
    required String id,
    required String name,
    required String description,
    required String type,
    required String date,
    required String place,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('itineraries')
        .doc(id)
        .collection('agendas')
        .add({
          "name": name,
          "description": description,
          "type": type,
          "date": Helper.formatDateToISO8601(date),
          "place": place,
          "userId": userId,
        });
  }

  Future<void> updateAgenda({required String itineraryId,
    required String agendaId,required String name,
    required String description,
    required String type,
    required String date,
    required String place,}) async {
      await firestore
        .collection('users')
        .doc(userId)
        .collection('itineraries')
        .doc(itineraryId)
        .collection('agendas')
        .doc(agendaId)
        .update({
          "name": name,
          "description": description,
          "type": type,
          "date": Helper.formatDateToISO8601(date),
          "place": place,
          "userId": userId,
        });
    }

  Future<void> deleteAgenda({
    required String itineraryId,
    required String agendaId,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('itineraries')
        .doc(itineraryId)
        .collection('agendas')
        .doc(agendaId)
        .delete();
  }
}
