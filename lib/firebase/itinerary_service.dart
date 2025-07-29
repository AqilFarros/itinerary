part of 'firebase.dart';

class ItineraryService {
  final firestore = FirebaseFirestore.instance;
  final userId = AuthService().auth.currentUser!.uid;

  Stream<QuerySnapshot> getItinerary() {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('itineraries')
        .orderBy('from')
        .orderBy('to')
        .snapshots();
  }

  Stream<DocumentSnapshot> getItineraryById(String id) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('itineraries')
        .doc(id)
        .snapshots();
  }

  Stream<QuerySnapshot> getAgenda(String id) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('itineraries')
        .doc(id)
        .collection('agendas')
        .orderBy('date')
        .snapshots();
  }

  Future<void> addItenerary({
    required String place,
    // required File image,
    required String description,
    required String from,
    required String to,
    required String type,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('itineraries')
        .add(({
          "place": place,
          // "image": image,
          "description": description,
          "type": type,
          "from": Helper.formatDateToISO8601(from),
          "to": Helper.formatDateToISO8601(to),
        }));
  }

  Future<void> updateItinerary({
    required String id,
    required String place,
    // required File image,
    required String description,
    required String from,
    required String to,
    required String type,
  }) async {
    await firestore
        .collection("users")
        .doc(userId)
        .collection("itineraries")
        .doc(id)
        .update({
          "place": place,
          // "image": image,
          "description": description,
          "type": type,
          "from": Helper.formatDateToISO8601(from),
          "to": Helper.formatDateToISO8601(to),
        });
  }

  Future<void> deleteItinerary(String id) async {
    final itineraryRef = firestore
        .collection("users")
        .doc(userId)
        .collection("itineraries")
        .doc(id);

    final agendasSnapshot = await itineraryRef.collection("agendas").get();

    final deleteAgendas = agendasSnapshot.docs.map(
      (doc) => doc.reference.delete(),
    );

    await Future.wait(deleteAgendas);

    await itineraryRef.delete();
  }
}
