import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Fetch the document from the 'displayName' collection
      final displayNameDoc =
          await _firestore.collection('displayName').doc(user.uid).get();
      if (displayNameDoc.exists) {
        return displayNameDoc.data()?['username'] ??
            'User'; // Fetch the 'username' field
      } else {
        throw Exception('DisplayName document not found');
      }
    } else {
      throw Exception('User not logged in');
    }
  }
}
