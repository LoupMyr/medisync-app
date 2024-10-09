import 'package:app/Services/SecureStorageService.dart';

abstract class AbstractController {
  final String uri = 'http://10.60.12.120:3000';
  final SecureStorageService secureStorageService = SecureStorageService();
}