
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kk_phim/models/latest_list_movie_model.dart';
import 'package:kk_phim/utils/img.dart';

import '../resources/kk_phim_provider.dart';


enum TypeMovie{
  tvShows('tv-shows'),
  feature('phim-le'),
  cartoon('hoat-hinh'),
  tvSeries('phim-bo');

  const TypeMovie(this.category);
  final String category;
}
enum GenresMovie{
  hanhDong('hanh dong', FreezeImg.imgHanhDong, 'Hành động'),
  kinhDi('kinh di',FreezeImg.imgKinhDi, 'Kinh dị'),
  drama('drama',FreezeImg.imgDrama, 'Drama'),
  vienTuong('vien tuong',FreezeImg.imgVienTuong, 'Viễn tưởng'),
  chienTrang('chien chanh',FreezeImg.imgChienTranh, 'Chiến tranh'),
  coTrang('co trang',FreezeImg.imgCoTrang, 'Cổ trang'),
  theThao('The thao',FreezeImg.imgTheThao, 'Thể thao'),
  tamLy('Tam ly',FreezeImg.imgTamLy, 'Tâm lý'),
  haiHuoc('hai huoc',FreezeImg.imgHai, 'Hài hước'),
  hocDuong('hoc duong',FreezeImg.imgHocDuong, 'Học đường'),
  voThuat('Vo thuat',FreezeImg.imgVoThuat, 'Võ thuật'),
  thanThoai('Than thoai',FreezeImg.imgThanThoai, 'Thần thoại');

  const GenresMovie(this.keyword, this.img, this.categoryName);
  final String keyword;
  final String img;
  final String categoryName;
}
class ListMovieModel {
  String? status;
  String? msg;
  Data? data;

  ListMovieModel({this.status, this.msg, this.data});

  ListMovieModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  void addItem(List<Items> list){
      if(data?.items == null) return;
      data!.items!.addAll(list);
  }
}

class Data {
  SeoOnPage? seoOnPage;
  List<BreadCrumb>? breadCrumb;
  String? titlePage;
  List<Items>? items;
  Params? params;
  String? typeList;
  String? aPPDOMAINFRONTEND;
  String? aPPDOMAINCDNIMAGE;

  Data(
      {this.seoOnPage,
        this.breadCrumb,
        this.titlePage,
        this.items,
        this.params,
        this.typeList,
        this.aPPDOMAINFRONTEND,
        this.aPPDOMAINCDNIMAGE});
  void addItems(List<Items> listItems){
    if(items == null) return;
      items!.addAll(listItems);
  }
  Data.fromJson(Map<String, dynamic> json) {
    seoOnPage = json['seoOnPage'] != null
        ? new SeoOnPage.fromJson(json['seoOnPage'])
        : null;
    if (json['breadCrumb'] != null) {
      breadCrumb = <BreadCrumb>[];
      json['breadCrumb'].forEach((v) {
        breadCrumb!.add(new BreadCrumb.fromJson(v));
      });
    }
    titlePage = json['titlePage'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    params =
    json['params'] != null ? new Params.fromJson(json['params']) : null;
    typeList = json['type_list'];
    aPPDOMAINFRONTEND = json['APP_DOMAIN_FRONTEND'];
    aPPDOMAINCDNIMAGE = json['APP_DOMAIN_CDN_IMAGE'];
  }

}

class SeoOnPage {
  String? ogType;
  String? titleHead;
  String? descriptionHead;
  List<String>? ogImage;
  String? ogUrl;

  SeoOnPage(
      {this.ogType,
        this.titleHead,
        this.descriptionHead,
        this.ogImage,
        this.ogUrl});

  SeoOnPage.fromJson(Map<String, dynamic> json) {
    ogType = json['og_type'];
    titleHead = json['titleHead'];
    descriptionHead = json['descriptionHead'];
    ogImage = json['og_image'].cast<String>();
    ogUrl = json['og_url'];
  }
}

class BreadCrumb {
  String? name;
  String? slug;
  bool? isCurrent;
  int? position;

  BreadCrumb({this.name, this.slug, this.isCurrent, this.position});

  BreadCrumb.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    isCurrent = json['isCurrent'];
    position = json['position'];
  }
}

class Items extends LatestItems{
  String? type;
  bool? subDocquyen;
  bool? chieurap;
  String? time;
  String? episodeCurrent;
  String? quality;
  String? lang;
  List<Category>? category;
  List<Country>? country;

  Items(
      {
        this.type,
        this.subDocquyen,
        this.chieurap,
        this.time,
        this.episodeCurrent,
        this.quality,
        this.lang,
        this.category,
        this.country});
  DateTime getDate(){
    if(time == null) return DateTime.now();
    return DateTime.parse(time!);

  }
  Items.fromJson(Map<String, dynamic> json) {
    modified = json['modified'] != null
        ? new Modified.fromJson(json['modified'])
        : null;
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    originName = json['origin_name'];
    type = json['type'];
    posterUrl = "${KkPhimProvider.imgUrl}/${json['poster_url']}";
    thumbUrl = json['thumb_url'];
    subDocquyen = json['sub_docquyen'];
    chieurap = json['chieurap'];
    time = json['time'];
    episodeCurrent = json['episode_current'];
    quality = json['quality'];
    lang = json['lang'];
    year = json['year'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(new Country.fromJson(v));
      });
    }
  }

}

class Category {
  String? id;
  String? name;
  String? slug;

  Category({this.id, this.name, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

}

class Params {
  String? typeSlug;
  List<String>? filterCategory;
  List<String>? filterCountry;
  String? filterYear;
  String? filterType;
  String? sortField;
  String? sortType;
  Pagination? pagination;

  Params(
      {this.typeSlug,
        this.filterCategory,
        this.filterCountry,
        this.filterYear,
        this.filterType,
        this.sortField,
        this.sortType,
        this.pagination});

  Params.fromJson(Map<String, dynamic> json) {
    typeSlug = json['type_slug'];
    filterCategory = json['filterCategory'].cast<String>();
    filterCountry = json['filterCountry'].cast<String>();
    filterYear = json['filterYear'];
    filterType = json['filterType'];
    sortField = json['sortField'];
    sortType = json['sortType'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
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

class Country{
  String? id;
  String? name;
  String? slug;

  Country({this.id, this.name, this.slug});
  Country.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }
}