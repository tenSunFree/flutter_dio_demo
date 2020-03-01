import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio_demo/common/utils/utils.dart';
import 'package:flutter_dio_demo/home/home.dart';
import 'package:flutter_dio_demo/home/model/photos_pojo.dart';
import 'package:flutter_dio_demo/home/presenter/home_presenter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PhotosPojo> photosPojoList;
  var isLoading = false;

  /// this function is called only once in the life cycle
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('flutter_dio_demo')),
      body: isLoading ? showProgressBar() : showRecyclerView(),
    );
  }

  _fetchData() {
    _setLoading(true);
    HomePresenter().getPhotos(
      params: null,
      onResponse: (response) {
        var dynamicList = json.decode(response) as List<dynamic>;
        photosPojoList = dynamicList.map((dynamic map) {
          return PhotosPojo.fromMap(map);
        }).toList();
        _setLoading(false);
      },
      onFailure: (throwable) {
        showToast(throwable);
        _setLoading(false);
      },
    );
  }

  _setLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  Center showProgressBar() => Center(child: CircularProgressIndicator());

  GridView showRecyclerView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
      ),
      itemCount: photosPojoList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: <Widget>[
            showBackgroundImage(index),
            Column(
              children: <Widget>[
                showIdText(index),
                showTitleText(index),
              ],
            ),
          ],
        );
      },
    );
  }

  InkWell showBackgroundImage(int index) {
    return InkWell(
      onTap: () {
        showToast("${photosPojoList[index].title}");
      },
      child: CachedNetworkImage(
        imageUrl: photosPojoList[index].url,
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }

  Expanded showIdText(int index) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          '${photosPojoList[index].id}',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Expanded showTitleText(int index) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        child: Text(
          '${photosPojoList[index].title}',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
