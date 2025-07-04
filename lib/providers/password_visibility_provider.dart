import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider =
    StateProvider.family<bool, String>((ref, id) => false);
