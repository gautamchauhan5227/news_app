import 'package:chopper/chopper.dart';

part 'network_service.chopper.dart';

@ChopperApi()
abstract class NetworkService extends ChopperService {
  @Get(path: 'top-headlines?apiKey=0775f6117e0e438b90ad056c031f8ca2')
  Future<Response> getTopHeadlines(
    @Query('country') String country,
  );

  @Get(path: 'everything?apiKey=0775f6117e0e438b90ad056c031f8ca2')
  Future<Response> searchArticles(
    @Query('q') String query,
  );

  static NetworkService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://newsapi.org/v2'),
      services: [
        _$NetworkService(),
      ],
      converter: const JsonConverter(),
    );
    return _$NetworkService(client);
  }
}
