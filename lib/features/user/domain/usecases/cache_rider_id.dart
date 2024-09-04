import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class CacheRiderId {
  final UserRepository repository;

  CacheRiderId({required this.repository});

  call(int id) {
    return repository.cacheRiderId(id);
  }
}
