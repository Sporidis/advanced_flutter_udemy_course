class SliderObject {
  String title;
  String subtitle;
  String image;
  SliderObject(this.title, this.subtitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String email;
  String link;
  String phone;
  Contacts(this.email, this.link, this.phone);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}
