import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import 'auth_remote_ds_helpers.dart'; // FsPaths
import 'core/auth_remote_core.dart';

mixin AuthRemoteProfileOps on AuthRemoteCore {
  fs.DocumentReference<Map<String, dynamic>> _profileDoc(String uid) =>
      firestore.collection(FsPaths.profiles).doc(uid);

  Future<void> upsertProfile(String uid, Map<String, dynamic> data) async {
    await firestore.runTransaction((tx) async {
      final ref = _profileDoc(uid);
      final snap = await tx.get(ref);
      final now = fs.FieldValue.serverTimestamp();

      if (!snap.exists) {
        tx.set(ref, {'id': uid, ...data, 'createdAt': now, 'updatedAt': now}, fs.SetOptions(merge: true));
      } else {
        tx.set(ref, {'id': uid, ...data, 'updatedAt': now}, fs.SetOptions(merge: true));
      }
    });
  }

  Future<void> ensureUserProfile(Object user, {Map<String, dynamic> extra = const {}}) async {
    final u = user as dynamic; // keep DS flexible
    final base = {'id': u.uid, 'email': u.email, 'displayName': u.displayName, 'photoURL': u.photoURL};
    await upsertProfile(u.uid, {...base, ...extra});
  }

  fs.DocumentReference<Map<String, dynamic>> profileDocPublic(String uid) => _profileDoc(uid);

  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final snap = await _profileDoc(uid).get();
    return snap.data();
  }
}
