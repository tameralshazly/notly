// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notly/services/auth/bloc/auth_bloc.dart';
import 'package:notly/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(
        children: [
          const Text(
              "We've already sent you an email verification. Please open it to verify your account."),
          const Text(
              "If you haven't received a verification email, press the button below."),
          TextButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
            },
            child: const Text("Send email verification"),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
