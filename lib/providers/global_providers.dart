import 'package:flutter_temp/providers/generate_qr_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final generateQrProvider = ChangeNotifierProvider<GenerateQrProvider>((ref) {
  return GenerateQrProvider();
});
