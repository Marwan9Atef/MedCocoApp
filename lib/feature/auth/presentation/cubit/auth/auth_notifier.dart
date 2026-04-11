import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:valo/feature/auth/presentation/cubit/auth/auth_cubit.dart';

class AuthNotifier extends ChangeNotifier {
  late final StreamSubscription _sub;

  AuthNotifier(AuthCubit cubit) {
    _sub = cubit.stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
