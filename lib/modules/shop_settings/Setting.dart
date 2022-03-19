import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class Setting extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is shopProfileSuccessState) {
          nameController.text = state.userModel!.name;
          emailController.text = state.userModel!.email;
          phoneController.text = state.userModel!.phone;
        }
        if (state is shopUpdateProfileSuccessState) {
          defaultToast(
            message: state.loginModel!.message,
            colorsToaster: colorsToast.SUCCESS,
          );
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => state is shopProfileSuccessState,
          widgetBuilder: (context) => defaultProfile(
            context: context,
            cubit: cubit,
          ),
          fallbackBuilder: (context) => defaultLoading(),
        );
      },
    );
  }

  Widget defaultProfile({
    required BuildContext context,
    required ShopCubit cubit,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            defaultTextFormField(
              controller: nameController,
              text: "Name",
              iconData: Icons.account_circle_outlined,
              textInputType: TextInputType.name,
              validation: (value) {
                if (value!.isEmpty) {
                  return "name is requeued";
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
                if (value!.isEmpty) {
                  return "Email is requeued";
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            defaultTextFormField(
              controller: phoneController,
              text: "Password",
              iconData: Icons.lock_outline,
              textInputType: TextInputType.visiblePassword,
              validation: (value) {
                if (value!.isEmpty) {
                  return "password is requeued";
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            defaultButton(
              text: "Update",
              function: () {
                if (formKey.currentState!.validate()) {
                  cubit.updateInfoUser(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            defaultButton(
              text: "Log Out",
              function: () {
                cubit.logOut(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
