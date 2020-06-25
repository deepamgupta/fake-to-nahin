class UserModel {
  // underscore '_' in front of variable and mthods means that particular element of the class is private.
  String id;
  String email;
  String username;
  String firstName;
  String lastName;
  String country;
  String state;
  String city;
  String mobile;
  String password;
  String imagePath;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this._description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  // UserModel(this._email, this._username, this._firstName, this._lastName,
  //     this._country, this._state, this._city, this._mobile, this._password,
  //     [this._imagePath]);

  UserModel();
  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  UserModel.withId(
      this.id,
      this.email,
      this.username,
      this.firstName,
      this.lastName,
      this.country,
      this.state,
      this.city,
      this.mobile,
      this.password,
      [this.imagePath]);

  // method to transform out Todo into a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["email"] = email;
    map["username"] = username;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["country"] = country;
    map["state"] = state;
    map["city"] = city;
    map["mobile"] = mobile;
    map["password"] = password;
    map["imagePath"] = imagePath;

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it into a Todo
  UserModel.toObject(dynamic o) {
    this.id = o["id"];
    this.email = o["email"];
    this.username = o["username"];
    this.firstName = o["firstName"];
    this.lastName = o["lastName"];
    this.country = o["country"];
    this.state = o["state"];
    this.city = o["city"];
    this.mobile = o["mobile"];
    this.password = o["password"];
    this.imagePath = o["imagePath"];
  }
}
