class UserData {
  String name;
  String date;
  String launch;
  String rating;

  UserData(
      String nameData, String dateData, String launchData, String ratingData) {
    name = nameData;
    date = dateData;
    launch = launchData;
    rating = ratingData;
  }

  UserData.fromMap(Map map)
      : this.name = map['name'],
        this.date = map['phone'],
        this.launch = map['email'],
        this.rating = map['rating'];

  Map toMap() {
    return {'name': name, 'date': date, 'launch': launch, 'rating': rating};
  }
}
