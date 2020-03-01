import 'package:flutter_dio_demo/common/utils/dio_utils.dart';

class HomeModel {

  void getPhotos(Map params, Function onResponse, Function onFailure) {
    DioUtils.getInstance().get(
        endPoint: '/photos',
        params: params,
        onResponse: onResponse,
        onFailure: onFailure);
  }
}







