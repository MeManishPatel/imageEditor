class StickerResponseModel {
  int? status;
  bool? success;
  String? message;
  Data? data;

  StickerResponseModel({this.status, this.success, this.message, this.data});

  StickerResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? int.parse(json['status'].toString()) : null;
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<StickerData>? stickerData;
  int? from;
  int? lastPage;
  String? nextPageUrl;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.stickerData,
      this.from,
      this.lastPage,
      this.nextPageUrl,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] != null
        ? int.parse(json['current_page'].toString())
        : null;
    if (json['data'] != null) {
      stickerData = <StickerData>[];
      json['data'].forEach((v) {
        stickerData!.add(StickerData.fromJson(v));
      });
    }
    from = json['from'] != null ? int.parse(json['from'].toString()) : null;
    lastPage = json['last_page'] != null
        ? int.parse(json['last_page'].toString())
        : null;
    nextPageUrl = json['next_page_url'];
    perPage = json['per_page'] != null
        ? int.parse(json['per_page'].toString())
        : null;
    prevPageUrl = json['prev_page_url'];
    to = json['to'] != null ? int.parse(json['to'].toString()) : null;
    total = json['total'] != null ? int.parse(json['total'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (stickerData != null) {
      data['data'] = stickerData!.map((v) => v.toJson()).toList();
    }
    data['from'] = from;
    data['last_page'] = lastPage;
    data['next_page_url'] = nextPageUrl;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class StickerData {
  int? id;
  String? image;

  StickerData({this.id, this.image});

  StickerData.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
