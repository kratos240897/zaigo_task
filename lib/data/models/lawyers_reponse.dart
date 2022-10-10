class LawyersResponse {
  LawyersResponse({
    required this.message,
    required this.code,
    required this.data,
    required this.pages,
    required this.states,
  });
  late final String message;
  late final int code;
  late final List<Data> data;
  late final int pages;
  late final List<States> states;

  LawyersResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    pages = json['pages'];
    states = List.from(json['states']).map((e) => States.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['code'] = code;
    map['data'] = data.map((e) => e.toJson()).toList();
    map['pages'] = pages;
    map['states'] = states.map((e) => e.toJson()).toList();
    return map;
  }
}

class Data {
  Data({
    required this.id,
    required this.uuid,
    required this.name,
    required this.address,
    required this.state,
    required this.fieldOfExpertise,
    required this.bio,
    required this.level,
    required this.hoursLogged,
    required this.phoneNo,
    required this.email,
    required this.areasOfPractise,
    required this.serviceOffered,
    required this.profilePicture,
    required this.rating,
    required this.ranking,
  });
  late final int id;
  late final String uuid;
  late final String name;
  late final String address;
  late final String state;
  late final String fieldOfExpertise;
  late final String bio;
  late final String level;
  late final String hoursLogged;
  late final String phoneNo;
  late final String email;
  late final List<dynamic> areasOfPractise;
  late final List<dynamic> serviceOffered;
  late final String profilePicture;
  late final String rating;
  late final String ranking;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    address = json['address'];
    state = json['state'];
    fieldOfExpertise = json['field_of_expertise'];
    bio = json['bio'];
    level = json['level'];
    hoursLogged = json['hours_logged'];
    phoneNo = json['phone_no'];
    email = json['email'];
    areasOfPractise =
        List.castFrom<dynamic, dynamic>(json['areas_of_practise']);
    serviceOffered = List.castFrom<dynamic, dynamic>(json['service_offered']);
    profilePicture = json['profile_picture'];
    rating = json['rating'];
    ranking = json['ranking'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['uuid'] = uuid;
    map['name'] = name;
    map['address'] = address;
    map['state'] = state;
    map['field_of_expertise'] = fieldOfExpertise;
    map['bio'] = bio;
    map['level'] = level;
    map['hours_logged'] = hoursLogged;
    map['phone_no'] = phoneNo;
    map['email'] = email;
    map['areas_of_practise'] = areasOfPractise;
    map['service_offered'] = serviceOffered;
    map['profile_picture'] = profilePicture;
    map['rating'] = rating;
    map['ranking'] = ranking;
    return map;
  }
}

class States {
  States({
    required this.stateName,
    required this.id,
  });
  late final String stateName;
  late final int id;

  States.fromJson(Map<String, dynamic> json) {
    stateName = json['state_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state_name'] = stateName;
    map['id'] = id;
    return map;
  }
}
