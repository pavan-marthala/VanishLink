import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

abstract class ChatRepository {
  Stream<List<UserProfile>> watchContacts();
}
