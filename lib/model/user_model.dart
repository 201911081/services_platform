class UserModel{
  String? name;
  String? email;
  String? phone;
  String? confirm;
  String? uId;
  String? image;
  String? password;

UserModel({
  this.name,
  this.email,
  this.phone,
  this.confirm,
  this.uId,
  this.image,
  this.password,

});

UserModel.fromJson(Map<String, dynamic>?json){
name =json!['name'];
email =json['email'];
phone =json['phone'];
confirm =json['confirm'];
uId =json['uId'];
image =json['image'];
password =json['password'];
}
  Map<String, dynamic>toMap(){
  return{
    'name': name,
    'email': email,
    'phone': phone,
    'uId': uId,
    'image': image,
    'password': password,
    'confirm': confirm,

  };
  }

}