part of '../di/service_locator.dart';

class NetworkManager {
  NetworkManager(
    this._httpService,
    this._cacheService,
  ) {
    _httpService.interceptors.add(
      InterceptorsWrapper(
        // Add the token to the headers
        onRequest: (options, handler) async {
          options.headers['Accept'] = Headers.jsonContentType;
          final token = await _cacheService.read(StorageKey.accessToken);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == HttpStatus.unauthorized) {
            final refreshToken = await _refreshToken();
            if (refreshToken != null) {
              _httpService.options.headers['Authorization'] =
                  'Bearer $refreshToken';
              final newRequest = await _httpService.fetch(error.requestOptions);
              return handler.resolve(newRequest); // Retry the request
            }
          }

          handler.reject(error);
        },
      ),
    );
  }

  final Dio _httpService;
  final CacheService _cacheService;

  Future<Response<T>> get<T>(String path, {Object? data}) async {
    return await _httpService.get<T>(path, data: data);
  }

  Future<Response<T>> post<T>(String path, {Object? data}) async {
    return await _httpService.post<T>(path, data: data);
  }

  Future<Response<T>> put<T>(String path, {Object? data}) async {
    return await _httpService.put<T>(path, data: data);
  }

  Future<Response<T>> delete<T>(String path, {Object? data}) async {
    return await _httpService.delete<T>(path, data: data);
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _cacheService.read(StorageKey.refreshToken);
    final response = await post('/refresh_token', data: {
      'refreshToken': refreshToken,
    });

    final accessToken = response.data['accessToken'];

    if (accessToken != null) {
      await _cacheService.write(StorageKey.accessToken, accessToken);
    }

    return accessToken;
  }
}
