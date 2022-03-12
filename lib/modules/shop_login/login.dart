import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:store/modules/shop_login/cubit/cubit.dart';
import 'package:store/modules/shop_login/cubit/states.dart';

import '../../layout/ShopLayout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cashe_helper.dart';
import '../shop_register/Register.dart';



class LoginShop extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.setData(
                key: "token",
                value: state.loginModel.Data!.token,
              ).then((value) {
                defaultToast(
                  message: state.loginModel.message,
                  colorsToaster: colorsToast.SUCCESS,
                );
                navigateToRemove(
                  context: context,
                  Widget: ShopLayout(),
                );
              });
            } else {
              defaultToast(
                message: state.loginModel.message,
                colorsToaster: colorsToast.ERROR,
              );
            }
            print("new token in login ${CacheHelper.getString(key: "token")}");
          }
          if (state is ShopLoginErrorState) {
            print(state.error);
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "login now to browse pur hot offers",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          text: "Email Address",
                          iconData: Icons.email_outlined,
                          textInputType: TextInputType.emailAddress,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          text: "Password",
                          iconData: Icons.lock_outline_sharp,
                          textInputType: TextInputType.visiblePassword,
                          suffix: cubit.iconSuffix,
                          isSecure: cubit.isSecure,
                          suffixFunction: () {
                            cubit.changeStateSecure();
                          },
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password is required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! ShopLoginLoadingState,
                          widgetBuilder: (context) => defaultButton(
                            text: "login",
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallbackBuilder: (context) => Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  Widget: Register(),
                                );
                              },
                              child: Text(
                                "Register Now!",
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
