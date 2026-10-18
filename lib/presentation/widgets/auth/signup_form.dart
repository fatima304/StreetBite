import 'package:food_delivery/core/helper/localized_validation.dart';
import 'package:food_delivery/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/helper/validator.dart';
import 'package:food_delivery/core/style/app_text_styles.dart';
import 'package:food_delivery/core/widgets/custom_button.dart';
import 'package:food_delivery/core/widgets/custom_text_form_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
    required this.onValidSubmit,
    this.isLoading = false,
  });
  final void Function(String name, String email, String password) onValidSubmit;
  final bool isLoading;
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool hidden = true;
  final key = GlobalKey<FormState>();
  final name = TextEditingController(), email = TextEditingController();
  final password = TextEditingController(), confirm = TextEditingController();
  bool agreed = false;
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    confirm.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: key,
    child: Column(
      children: [
        CustomTextFormField(
          controller: name,
          hintText: AppLocalizations.of(context)!.fullName,
          prefixIcon: const Icon(Icons.person_outline),
          validator: (value) => LocalizedValidation.message(
            context,
            AuthValidators.fullName(value),
          ),
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          controller: email,
          hintText: AppLocalizations.of(context)!.emailAddress,
          prefixIcon: const Icon(Icons.mail_outline),
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              LocalizedValidation.message(context, AuthValidators.email(value)),
        ),
        const SizedBox(height: 12),

        const SizedBox(height: 12),
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

        const SizedBox(height: 12),
        CustomTextFormField(
          controller: confirm,
          hintText: AppLocalizations.of(context)!.confirmPassword,
          prefixIcon: const Icon(Icons.lock_outline),
          obscureText: true,
          validator: (value) => LocalizedValidation.message(
            context,
            AuthValidators.confirmPassword(value, password.text),
          ),
        ),
        const SizedBox(height: 12),
        CheckboxListTile(
          value: agreed,
          onChanged: (v) => setState(() => agreed = v ?? false),
          activeColor: Theme.of(context).colorScheme.primary,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          title: Text(
            AppLocalizations.of(context)!.termsAgreement,
            style: AppTextStyles.body14DarkRegular.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: widget.isLoading
              ? AppLocalizations.of(context)!.creatingAccount
              : AppLocalizations.of(context)!.createAccount,
          onPressed: widget.isLoading
              ? null
              : () {
                  if (!key.currentState!.validate()) return;
                  if (!agreed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.acceptTerms,
                        ),
                      ),
                    );
                    return;
                  }
                  widget.onValidSubmit(
                    name.text.trim(),
                    email.text.trim(),
                    password.text,
                  );
                },
        ),
      ],
    ),
  );
}
