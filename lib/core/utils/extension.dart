import 'package:fivoza/core/utils/enum.dart';

extension ResponseTypesExtension on ResponseTypes {
  String get response => ['Success', 'Failure'][index];
}
