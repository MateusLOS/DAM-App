import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    // Configurar opções básicas do Dio
    dio.options.baseUrl = 'YOUR_BACKEND_URL_HERE'; // URL base da sua API
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);

    // Adicionar interceptores (opcional)
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}c