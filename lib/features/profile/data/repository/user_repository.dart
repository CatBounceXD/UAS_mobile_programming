import '../models/user_models.dart';

abstract class IUserRepository {
  Future<UserModel?> getUser(String uid);
  Future<void> updateUser(UserModel user);
  Future<List<UserModel>> getSwipeCandidates(String currentUid, String targetGender);
}