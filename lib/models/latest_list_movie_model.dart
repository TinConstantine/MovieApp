class LatestListMovieModel {
  bool? status;
  List<LatestItems>? items;
  Pagination? pagination;

  LatestListMovieModel({this.status, this.items, this.pagination});

  LatestListMovieModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['items'] != null) {
      items = <LatestItems>[];
      json['items'].forEach((v) {
        items!.add( LatestItems.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ?  Pagination.fromJson(json['pagination'])
        : null;
  }

  List<LatestItems> getLatestItem(int count){
    if(items == null) return [];
    List<LatestItems> newList = [];
    for(int i = 0; i < count; i++) {
      newList.add(items![i]);
    }
    return newList;
  }
}

class LatestItems {
  Modified? modified;
  String? sId;
  String? name;
  String? slug;
  String? originName;
  String? posterUrl;
  String? thumbUrl;
  int? year;

  LatestItems(
      {this.modified,
        this.sId,
        this.name,
        this.slug,
        this.originName,
        this.posterUrl,
        this.thumbUrl,
        this.year});
  LatestItems.fromJson(Map<String, dynamic> json) {
    modified = json['modified'] != null
        ? Modified.fromJson(json['modified'])
        : null;
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    originName = json['origin_name'];
    posterUrl = json['poster_url'];
    thumbUrl = json['thumb_url'];
    year = json['year'];
  }

}

class Modified {
  String? time;

  Modified({this.time});

  Modified.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['time'] = time;
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? totalItemsPerPage;
  int? currentPage;
  int? totalPages;

  Pagination(
      {this.totalItems,
        this.totalItemsPerPage,
        this.currentPage,
        this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    totalItemsPerPage = json['totalItemsPerPage'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

}
