part of 'login_widgets.dart';

/// Wrapper that listens to the [LoginBloc] provided and reacts with dialogs and toasts.
class DialogAndToastWrapper extends StatelessWidget {
  /// Wrapper that listens to the [LoginBloc] provided and reacts with dialogs and toasts.
  const DialogAndToastWrapper({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // Dialog
        if (state.showDialog) {
          showForgotPasswordDialog(context);
        }

        // Toast
        if (state.status is Error) {
          final message = (state.status as Error).errorMessage;
          if (message.isNotEmpty) {
            Fluttertoast.showToast(msg: message);
          }
        } else if (state.status is Idle) {
          final message = (state.status as Idle).message;
          if (message != null && message.isNotEmpty) {
            Fluttertoast.showToast(msg: message);
          }
        }
      },
      listenWhen: (state, previousState) =>
          (state.showDialog != previousState.showDialog) ||
          (state.status != previousState.status),
      child: child,
    );
  }
}
