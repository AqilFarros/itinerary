part of 'firebase.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  get currentUser => auth.currentUser;

  Future<User> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user!;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore.collection('users').doc(userCredential.user!.uid).set({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
      });

      return userCredential.user!;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    final DocumentSnapshot userDoc = await firestore
        .collection('users')
        .doc(currentUser!.uid)
        .get();

    return userDoc.data() as Map<String, dynamic>;
  }
}
