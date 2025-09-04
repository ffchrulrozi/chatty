import 'package:chatty/routes/paths.dart';
import 'package:chatty/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(isLoading: false));

  Future<void> login() async {
    state.isLoading = true;
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;

      var clientId =
          "111315039953-chddffgi4r6tkn01263hnchgsgd76r75.apps.googleusercontent.com";
      var serverClientId =
          "111315039953-erhdbt87lctdbnff68v79iqv2tg06ni4.apps.googleusercontent.com";
      signIn
          .initialize(clientId: clientId, serverClientId: serverClientId)
          .then((_) {
        signIn.authenticationEvents
            .listen(_handleAuthenticationEvent)
            .onError(_handleAuthenticationError);

        signIn.attemptLightweightAuthentication();
      });
    } catch (_) {
      state.message = "An unexpected error occured";
    }
  }

  _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    if (user != null) {
      final GoogleSignInAuthentication googleAuth = user.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      
      await FirebaseAuth.instance.signInWithCredential(credential);
      navigatorKey.currentContext?.go(PATH.DASHBOARD.path);
    }
  }

  Future<void> _handleAuthenticationError(Object e) async {
    final response = e is GoogleSignInException
        ? _errorMessageFromSignInException(e)
        : 'Unknown error: $e';

    state = AuthState(isLoading: false, message: response);
  }

  String _errorMessageFromSignInException(GoogleSignInException e) {
    return switch (e.code) {
      GoogleSignInExceptionCode.canceled => 'Sign in canceled',
      _ => 'GoogleSignInException ${e.code}: ${e.description}',
    };
  }
}

class AuthState {
  bool isLoading;
  String? message;
  AuthState({required this.isLoading, this.message});

  copyWith({bool? isLoading, String? message}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}
