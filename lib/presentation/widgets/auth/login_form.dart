import 'package:food_delivery/core/helper/localized_validation.dart';
import 'package:food_delivery/core/style/app_text_styles.dart';
import 'package:food_delivery/core/widgets/custom_button.dart';
import 'package:food_delivery/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/helper/validator.dart';
import 'package:food_delivery/core/widgets/custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.onValidSubmit,
    this.isLoading = false,
  });
  final void Function(String email, String password) onValidSubmit;
  final bool isLoading;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool hidden = true;
  final key = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: key,
    child: Column(
      children: [
        CustomTextFormField(
          controller: email,
          hintText: AppLocalizations.of(context)!.emailAddress,
          prefixIcon: const Icon(Icons.mail_outline),
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              LocalizedValidation.message(context, AuthValidators.email(value)),
        ),
        const SizedBox(height: 14),
        CustomTextFormField(
          controller: password,
          hintText: AppLocalizations.of(context)!.password,
          prefixIcon: const Icon(Icons.lock_outline),
          obscureText: hidden,
          validator: (value) => LocalizedValidation.message(
            context,
            AuthValidators.password(value),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              hidden
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () => setState(() => hidden = !hidden),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.resetNotConnected),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.forgotPassword,
              style: AppTextStyles.link14GreenMedium.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 34),
        CustomButton(
          text: widget.isLoading
              ? AppLocalizations.of(context)!.signingIn
              : AppLocalizations.of(context)!.signIn,
          onPressed: widget.isLoading
              ? null
              : () {
                  if (key.currentState!.validate()) {
                    widget.onValidSubmit(email.text.trim(), password.text);
                  }
                },
        ),
      ],
    ),
  );
}
