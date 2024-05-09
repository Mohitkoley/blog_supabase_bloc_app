import 'package:auto_route/auto_route.dart';
import 'package:blog_app/core/common/extensions/app_extension.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/validators/auth_validator.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/bottom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            context.showSnack(state.message);
          }
        },
        buildWhen: (previous, current) {
          return current is! AuthFailure;
        },
        builder: (context, state) {
          if (state is AuthLoading) return const Loader();

          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sign Up',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                  15.hBox,
                  AuthField(
                    hintText: 'Name',
                    validator: validateName,
                    controller: _nameController,
                  ),
                  15.hBox,
                  AuthField(
                    hintText: 'Email',
                    validator: validateEmail,
                    controller: _emailController,
                  ),
                  15.hBox,
                  AuthField(
                    hintText: 'Password',
                    validator: validatePassword,
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  20.hBox,
                  AuthGradientButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignUp(
                            email: _emailController.text,
                            name: _nameController.text,
                            password: _passwordController.text));
                      }
                    },
                    text: 'Sign Up',
                  ),
                  20.hBox,
                  BottomText(
                    text1: 'Already have an account? ',
                    text2: 'Login',
                    text1Tap: () {},
                    text2Tap: () {
                      context.router.maybePop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
