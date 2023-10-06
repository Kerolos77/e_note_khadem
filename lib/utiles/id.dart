import 'package:nanoid/nanoid.dart';

class ID {
  static String createId() {
    String v1 = nanoid(8);
    return v1.toUpperCase();
  }

}
