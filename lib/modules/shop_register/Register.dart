import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:store/layout/ShopLayout.dart';
import 'package:store/modules/shop_register/cubit/cubit.dart';
import 'package:store/modules/shop_register/cubit/states.dart';
import 'package:store/shared/components/constants.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cashe_helper.dart';

class Register extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.setData(
                key: "token",
                value: state.loginModel.Data!.token,
              ).then((value) {
                token = state.loginModel.Data!.token;
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
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
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
                          "Register",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Register now to browse pur hot offers",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          text: "Name",
                          iconData: Icons.account_circle_outlined,
                          textInputType: TextInputType.name,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          text: "Email",
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
                        defaultTextFormField(
                          controller: phoneController,
                          text: "Phone",
                          iconData: Icons.phone,
                          textInputType: TextInputType.phone,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone is required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! ShopRegisterLoadingState,
                          widgetBuilder: (context) => defaultButton(
                            text: "login",
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
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
