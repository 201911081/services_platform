class PostModel{
  String? name;
  String? uId;
  String? phone;
  String? image;
  String? firstPostImage;
  String? text;
  String? title;
  String? dateTime;

  PostModel({
    this.name,
    this.firstPostImage,
    this.uId,
    this.phone,
    this.image,
    this.text,
    this.title,
    this.dateTime,

  });

  PostModel.fromJson(Map<String, dynamic>json){
    name =json['name'];
    firstPostImage =json['firstPostImage'];
    uId =json['uId'];
    phone =json['phone'];
    image =json['image'];
    text =json['text'];
    title =json['title'];
    dateTime =json['dateTime'];
  }
  Map<String, dynamic>toMap(){
    return{
      'name': name,
      'firstPostImage': firstPostImage,
      'uId': uId,
      'phone': phone,
      'image': image,
      'text': text,
      'title': title,
      'dateTime': dateTime,

    };
  }

}