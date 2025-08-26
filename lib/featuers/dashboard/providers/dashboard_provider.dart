import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    Provider<User?>((ref) => FirebaseAuth.instance.currentUser);

final pageIndexProvider = StateProvider<int>((ref) => 0);