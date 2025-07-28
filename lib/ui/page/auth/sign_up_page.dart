part of '../page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final authService = AuthService();

  void signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await authService.signUp(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(AppTheme.defaultMargin * 2),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/logo.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Text(
                    "Sign up to continue",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          controller: firstNameController,
                          label: "First Name",
                          hint: "First Name",
                          textInputType: TextInputType.name,
                          validator: InputValidator.requiredField,
                        ),
                      ),
                      SizedBox(width: AppTheme.defaultMargin),
                      Expanded(
                        child: InputField(
                          controller: lastNameController,
                          label: "Last Name",
                          hint: "Last Name",
                          textInputType: TextInputType.name,
                          validator: InputValidator.requiredField,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  InputField(
                    controller: emailController,
                    hint: "Enter your email",
                    label: "Email",
                    textInputType: TextInputType.emailAddress,
                    validator: InputValidator.validateEmail,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  InputField(
                    controller: passwordController,
                    label: "Password",
                    hint: "Enter your password",
                    obscureText: true,
                    textInputType: TextInputType.visiblePassword,
                    validator: InputValidator.validatePassword,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  InputField(
                    controller: confirmPasswordController,
                    label: "Confirm Password",
                    hint: "Enter your password",
                    obscureText: true,
                    textInputType: TextInputType.visiblePassword,
                    validator: (value) =>
                        InputValidator.validateConfirmPassword(
                          passwordController.text,
                          value,
                        ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: isLoading
                        ? [
                            CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ]
                        : [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/sign-in',
                                );
                              },
                              child: Text(
                                "Already have an account?",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                            SizedBox(width: AppTheme.defaultMargin),
                            ElevatedButton(
                              onPressed: () {
                                signUp();
                              },
                              child: Text(
                                "Sign up",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
