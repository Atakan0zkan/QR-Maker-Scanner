import 'package:hive/hive.dart';

part 'qr_type.g.dart';

@HiveType(typeId: 2)
enum QRType {
  @HiveField(0)
  url,
  
  @HiveField(1)
  text,
  
  @HiveField(2)
  wifi,
  
  @HiveField(3)
  contact,
  
  @HiveField(4)
  email,
  
  @HiveField(5)
  sms,
  
  @HiveField(6)
  phone,
  
  @HiveField(7)
  location,
  
  @HiveField(8)
  social,
}
