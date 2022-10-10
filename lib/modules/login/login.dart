import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaigo_task/core/base_screen.dart';
import 'package:zaigo_task/bloc/login/login_bloc.dart';
import 'package:zaigo_task/helpers/utils.dart';
import 'package:zaigo_task/routes/routes.dart';
import 'package:zaigo_task/widgets/custom_text_field.dart';

class Login extends BaseScreen {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends BaseScreenState<Login> {
  late LoginBloc _bloc;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscureText = true;

  @override
  void initState() {
    _bloc = BlocProvider.of<LoginBloc>(context);
    _bloc.stream.listen(_blocListener);
    super.initState();
  }

  void _blocListener(LoginState state) {
    if (state is! LoginLoadingState) {
      hideLoading(context);
    }
    if (state is LoginFailState) {
      showSnackBar('Failed', state.message, context, false);
    } else if (state is LoginLoadingState) {
      showLoading(context);
    } else if (state is LoginSuccessState) {
      Navigator.of(context).pushReplacementNamed(Routes.HOME);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_header(), _inputSection()],
              ),
            ),
            const Spacer(),
            _loginButton(context)
          ],
        ),
      ),
    );
  }

  Widget _inputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: CustomTextField(
              controller: emailController,
              prefixIcon: Icons.person_outline,
            )),
        vSpace(16.0),
        Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: CustomTextField(
              controller: passwordController,
              prefixIcon: Icons.lock_outline,
              isObscureText: _isObscureText,
              onVisibilityToggled: () => setState(() {
                _isObscureText = !_isObscureText;
              }),
            )),
        vSpace(8.0),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {}, child: const Text('Forgot Password?')),
        )
      ],
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vSpace(height * 0.05),
        Text('Welcome User',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
        vSpace(8.0),
        Text('Enter your details to login to your Account',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.grey, fontSize: 16.0)),
        vSpace(32.0),
      ],
    );
  }

  Widget _loginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          _bloc.add(LoginInitEvent(
              email: emailController.text, password: passwordController.text));
        } else {
          showSnackBar('Invalid', 'Please enter valid phone and password',
              context, false);
        }
      },
      child: Container(
        width: width,
        height: height * 0.075,
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Text('LOGIN',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                fontSize: 18.0,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }
}
