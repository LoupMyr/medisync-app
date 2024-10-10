import 'package:app/Services/SecureStorageService.dart';

abstract class AbstractController {
  final String uri = 'http://localhost:3000';
  final SecureStorageService secureStorageService = SecureStorageService();
}