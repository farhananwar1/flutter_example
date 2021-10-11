class UploadImageModel {
  static ImageUpload? imageUpload;
  static Data? data;
}
class ImageUpload {
  int? status;
  String? message;
  Data? data;

  ImageUpload(
      {required this.status, required this.message, required this.data});

  ImageUpload.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? path;
  String? filename;

  Data({required this.path, required this.filename});

  Data.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['filename'] = this.filename;
    return data;
  }
}
