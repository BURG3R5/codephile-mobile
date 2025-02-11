import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/styles.dart';
import '../../components/inputs/text_input.dart';
import '../../components/widgets/primary_button.dart';
import '../bloc/update_profile_bloc.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.r),
                      Text(
                        'Setup a new password for Codephile',
                        style: AppStyles.h4.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 24.r),
                      _buildTextField(
                        context,
                        hint: 'Current Password',
                        index: 0,
                        activeIndex: state.activePasswordTextField,
                        obscure: state.passwordFieldObscureState[0],
                        controller: UpdateProfileBloc.controllers['old_pass'],
                      ),
                      SizedBox(height: 24.r),
                      _buildTextField(
                        context,
                        hint: 'New Password',
                        index: 1,
                        activeIndex: state.activePasswordTextField,
                        obscure: state.passwordFieldObscureState[1],
                        controller: UpdateProfileBloc.controllers['new_pass'],
                      ),
                      SizedBox(height: 24.r),
                      _buildTextField(
                        context,
                        hint: 'Re-enter Password',
                        index: 2,
                        activeIndex: state.activePasswordTextField,
                        obscure: state.passwordFieldObscureState[2],
                        controller: UpdateProfileBloc.controllers['re_enter'],
                        compareText:
                            UpdateProfileBloc.controllers['new_pass']?.text,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PrimaryButton(
              label: 'Update Password',
              onPressed: () {
                if (state.isUpdating) return;
                if (_key.currentState!.validate()) {
                  context.read<UpdateProfileBloc>().add(const UpdatePassword());
                }
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hint,
    required int index,
    required int activeIndex,
    required bool obscure,
    TextEditingController? controller,
    String? compareText,
  }) {
    return TextInput(
      key: UniqueKey(),
      hint: hint,
      validator: (val) {
        if (val?.isEmpty ?? true) {
          return 'Required Field';
        }
        // Re-enter field
        if (index == 2 && val != compareText) {
          return "It doesn't matches with new password";
        }
        return null;
      },
      onChanged: (val) {},
      controller: controller,
      obscureText: obscure,
      prefix: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.r,
          vertical: 10.r,
        ),
        child: ImageIcon(
          Svg(index == 0 ? AppAssets.lock : AppAssets.lockFilled),
        ),
      ),
      suffix: IconButton(
        onPressed: () {
          context.read<UpdateProfileBloc>().add(ToggleObscure(index: index));
        },
        icon: ImageIcon(
          Svg(obscure ? AppAssets.eyeOff : AppAssets.eyeOn),
        ),
      ),
    );
  }
}
