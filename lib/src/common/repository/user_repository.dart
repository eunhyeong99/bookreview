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

  Future<List<UserModel>> allUserInfos(List<String> uids) async {
    var doc = await db
        .collection('users')
        .where(
          'uid',
          whereIn: uids,
        )
        .get();

    if (doc.docs.isEmpty) {
      return [];
    } else {
      return doc.docs
          .map<UserModel>((data) => UserModel.fromJson(data.data()))
          .toList();
    }
  }
}
