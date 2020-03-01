import 'package:flutter/cupertino.dart';
import '../home.dart';

class HomePresenter {
  void getPhotos({
    @required Map params,
    @required Function onResponse,
    @required Function onFailure,
  }) {
    HomeModel().getPhotos(params, onResponse, onFailure);
  }
}
