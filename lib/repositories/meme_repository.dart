import 'package:algostudio/models/meme_model.dart';
import 'package:algostudio/services/network/api_response.dart';
import 'package:algostudio/services/network/interceptors/network_interceptor.dart';
import 'package:algostudio/services/network/network_client.dart';
import 'package:algostudio/services/network/url.dart';
import 'package:algostudio/utils/constants.dart';
import 'package:dio/dio.dart';

class MemeRepository{
  final NetworkClient _client = NetworkClient(
    dioClient: Dio(BaseOptions(baseUrl: Url.baseURL)),
    interceptors: [NetworkInterceptor()],
  );

  Future<APIResponse<List<MemeModel>>> getListMeme() async {
    try {
      final response = await _client.get(
          endpoint: Url.meme(MemeEndpoint.list)
      );

      var datas = response.data[Constants.data][Constants.memes] as List;

      APIResponse<List<MemeModel>> apiResponse = APIResponse(
        data: datas.map((data) => MemeModel.fromJson(data)).toList(),
        code: response.statusCode!,
        message: "",
        success: true,
      );

      return apiResponse;
    } on DioError catch(e){
      return _client.errorParser(e);
    }
  }
}