import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cashe_helper.dart';

class Setting extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is shopProfileSuccessState) {
          nameController.text = state.userModel!.name;
          emailController.text = state.userModel!.email;
          phoneController.text = state.userModel!.phone;
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.userModel != null,
          widgetBuilder: (context) => defaultProfile(context),
          fallbackBuilder: (context) => defaultLoading(),
        );
      },
    );
  }

  Widget defaultProfile(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          defaultTextFormField(
            controller: nameController,
            text: "Name",
            iconData: Icons.account_circle_outlined,
            textInputType: TextInputType.name,
          ),
          SizedBox(
            height: 20.0,
          ),
          defaultTextFormField(
            controller: emailController,
            text: "Email",
            iconData: Icons.email_outlined,
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 20.0,
          ),
          defaultTextFormField(
            controller: phoneController,
            text: "Password",
            iconData: Icons.lock_outline,
            textInputType: TextInputType.visiblePassword,
          ),
          SizedBox(
            height: 20.0,
          ),
          defaultButton(
            text: "Log Out",
            function: () {
              CacheHelper.removeData(key: "token");
              print("old token is ${token}");
              logOut(context);
            },
          )
        ],
      ),
    );
  }
}
