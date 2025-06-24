import 'package:dio/dio.dart'; 
class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.options.baseUrl = 'BACKEND_URL_AQUI'; 
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  /
  Future<Response> updateUserProfile(String userId, Map<String, dynamic> data) async {
    return await dio.put('/users/$userId/profile', data: data);
  }

  Future<Response> updateUserPassword(String userId, Map<String, dynamic> data) async {
    return await dio.put('/users/$userId/password', data: data);
  }

  Future<Response> updateUserProfileImage(String userId, FormData formData) async {
    return await dio.put('/users/$userId/profile-image', data: formData);
  }

  Future<Response> createMovie(Map<String, dynamic> data) async {
    return await dio.post('/movies', data: data);
  }

}