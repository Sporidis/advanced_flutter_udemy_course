import 'package:advanced_course_udemy/data/mapper/mapper.dart';

extension NonNullString on String?{
  String orEmpty(){
    if(this == null){
      return EMPTY;
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int?{
  int orZero(){
    if(this == null){
      return ZERO;
    } else {
      return this!;
    }
  }
}