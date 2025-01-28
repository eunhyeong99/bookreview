import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class UserRepository {
  FirebaseFirestore db;

  UserRepository(this.db);

  Future<UserModel?> findUserOne(String uid) async {
    try {
      var doc = await db.collection('users').where('uid', isEqualTo: uid).get();
      if (doc.docs.isEmpty) {
        return null;
      } else {
        return UserModel.fromJson(doc.docs.first.data());
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> joinUser(UserModel userModel) async {
    try {
      db.collection('users').add(userModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
