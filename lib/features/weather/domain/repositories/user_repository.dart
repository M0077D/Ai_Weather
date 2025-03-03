import 'package:task1/features/weather/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser();
}
