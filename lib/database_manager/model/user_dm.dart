class UserDm{
  static const String collectionName='users';
  static UserDm? userDm;
  String id;
  String userName;
  String fullName;
  String email;
  UserDm({required this.id,required this.userName,required this.fullName,required this.email});
  Map<String,dynamic>toFireStore()=>{
    'id':id,
    'fullName':fullName,
    'userName':userName,
    'email':email,
};
  UserDm.fromFireStore(Map<String,dynamic>json):this(
    id:json['id'],
    fullName: json['fullName'],
    userName: json['userName'],
    email: json['email'],
  );
}