import 'package:auto_route/auto_route.dart';
import 'package:blog_app/core/common/extensions/app_extension.dart';
import 'package:blog_app/core/validators/auth_validator.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/bottom_text.dart';
import 'package:blog_app/navigation/app_routing/app_router.dart';
import 'package:blog_app/navigation/route_name/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Log In',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
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
                        context.read<AuthBloc>().add(AuthLogin(
                            email: _emailController.text,
                            password: _passwordController.text));
                      }
                    },
                    text: 'Log In',
                  ),
                  20.hBox,
                  BottomText(
                    text1: 'Don\'t have an account? ',
                    text2: 'Sign Up',
                    text1Tap: () {},
                    text2Tap: () {
                      context.router.pushNamed(RouteNames.signUpView);
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
