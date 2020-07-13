class PostModel {
  // underscore '_' in front of variable and mthods means that particular element of the class is private.
  String id;
  String title;
  String description;
  String dateCreated;
  String username;
  String mediaPath;
  // List<ResourceModel> _resources;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this.description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  PostModel(
    this.title,
    this.username,
    this.dateCreated,
    this.description,
    this.mediaPath,
    // [this._resources]
  );

  // PostModel();
  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  PostModel.withId(
    this.id,
    this.title,
    this.username,
    this.dateCreated,
    this.description,
    this.mediaPath,
    // this._resources
  );

  // List<ResourceModel> get resources {
  //   return this._resources;
  // }

  //  Setters
  // set resources(List<ResourceModel> _resources) {
  //   _resources = new List<ResourceModel>.from(_resources);
  // }

  // method to transform out Todo Stringo a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["description"] = description;
    map["username"] = username;
    map["dateCreated"] = dateCreated;
    map["mediaPath"] = mediaPath;

    if (id != null) {
      map["id"] = id;
    }

    // if (_resources != null) {
    //   map["resources"] = _resources;
    // }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it Stringo a Todo
  PostModel.toObject(dynamic o) {
    this.id = o["id"];
    this.title = o["title"];
    this.description = o["description"];
    this.username = o["username"];
    this.dateCreated = o["dateCreated"];
    this.mediaPath = o["mediaPath"];
    // this.resources = o["resources"];
  }
}
