import 'package:task1/features/weather/domain/entities/user_entity.dart';
import 'package:task1/features/weather/domain/repositories/user_repository.dart';

import 'package:task1/features/weather/data/datasources/user_remote_user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getUser() async {
    final userName = await remoteDataSource.getUserName();
    return UserEntity(name: userName);
  }
}
