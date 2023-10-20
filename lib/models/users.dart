class User{
  String? email;
  String? fullName;
  int? phone;
  
  User({
    this.email,
    this.fullName,
    this.phone
  });

   toJson(){
    return {
      "email": email,
      "fullName": fullName,
      "phone": phone
    };
  }
}