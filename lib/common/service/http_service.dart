part of '../di/service_locator.dart';

final httpService = Dio(
  BaseOptions(
    baseUrl: 'https://muddy-snowflake-29281.pktriot.net',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 5),
  ),
);
