class User{
  String?id;
  String? email;
  String?name;
  List<String>? favorites;
  User(
  {this.id,this.email,this.name,this.favorites});

  User.fromFireStore(Map<String,dynamic>?data){
    id=data?["id"];
    email=data?["email"];
    name=data?["name"];
    favorites=List<String>.from(data?["favorites"]);
  }
  Map<String,dynamic>toFireStore(){
    return
        {
          "id":id,
          "email":email,
          "name":name,
          "favorites":favorites
        };
  }
  }

