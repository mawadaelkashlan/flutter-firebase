import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
          // if (state is SocialLoginSuccessState) {
          //   if (state.loginModel.status) {
          //     showToast(
          //         text: state.loginModel.message, state: ToastState.SUCCESS);
          //     CacheHelper.saveData(
          //         key: 'token', value: state.loginModel.data.token)
          //         .then((value) {
          //       token = state.loginModel.data.token!;
          //       navigateAndFinish(context, SocialLayout());
          //     });
          //   } else {
          //     // print(state.loginModel.message);
          //     // showToast(
          //     //     text: state.loginModel.message, state: ToastState.ERROR);
          //   }
          // }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'login now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultFormField(
                          controller: emailController,
                          validate: 'Please enter Email Address',
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined),
                      SizedBox(
                        height: 15,
                      ),
                      DefaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        validate: 'Password must not be Empty',
                        prefix: Icons.lock,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            // SocialLoginCubit.get(context).userLogin(
                            //     email: emailController.text,
                            //     password: passwordController.text);
                          }
                        },
                        isPassword: SocialLoginCubit.get(context).isPassword,
                        suffix: SocialLoginCubit.get(context).suffix,
                        suffixPressed: () {
                          SocialLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'Login',
                            isUpperCase: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          defaultTextButton(
                            text: 'register',
                            function: () {
                              navigateTo(context, RegisterScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
