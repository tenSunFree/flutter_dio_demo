class PhotosPojo {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  static PhotosPojo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PhotosPojo photosPojo = PhotosPojo();
    photosPojo.albumId = map['albumId'];
    photosPojo.id = map['id'];
    photosPojo.title = map['title'];
    photosPojo.url = map['url'];
    photosPojo.thumbnailUrl = map['thumbnailUrl'];
    return photosPojo;
  }
}
