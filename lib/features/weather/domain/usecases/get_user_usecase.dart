// domain/usecases/get_user_name.dart

import 'package:task1/features/weather/domain/entities/user_entity.dart';
import 'package:task1/features/weather/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase({required this.repository});

  Future<UserEntity> execute() async {
    return await repository.getUser();
  }
}
