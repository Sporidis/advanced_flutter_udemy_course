//to convert the response into a non nullable object (model)
// ignore_for_file: constant_identifier_names

import 'package:advanced_course_udemy/app/extensions.dart';
import 'package:advanced_course_udemy/data/responses/responses.dart';
import 'package:advanced_course_udemy/domain/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? EMPTY,
      this?.name?.orEmpty() ?? EMPTY,
      this?.numOfNotifications?.orZero() ?? ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone?.orEmpty() ?? EMPTY,
      this?.email?.orEmpty() ?? EMPTY,
      this?.link?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}
