// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$NetworkService extends NetworkService {
  _$NetworkService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = NetworkService;

  @override
  Future<Response<dynamic>> getTopHeadlines(String country) {
    final Uri $url =
        Uri.parse('top-headlines?apiKey=0775f6117e0e438b90ad056c031f8ca2');
    final Map<String, dynamic> $params = <String, dynamic>{'country': country};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> searchArticles(String query) {
    final Uri $url =
        Uri.parse('everything?apiKey=0775f6117e0e438b90ad056c031f8ca2');
    final Map<String, dynamic> $params = <String, dynamic>{'q': query};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
