import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woodog_app/bottom_view/bottom_navigation_bar.dart';
import 'package:woodog_app/models/user_model.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/routers/app_routes.dart';
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/color.dart';
import 'package:woodog_app/widgets/input_fileds.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<ApiResponse> _loginUser() async {
  setState(() {
    loading = true;
  });

  ApiResponse response =
      await login(emailController.text, passwordController.text);

  // Vérifie la présence du token et que la réponse est correcte
  if (response.data != null && (response.data as User).token != null) {
    _saveAndRedirectToHome(response.data as User);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message ?? 'Connecté avec succès'),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ));
  } else {
    setState(() {
      loading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '${response.message}. Veuillez vérifier les champs Email et Mot de passe'),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    ));
  }
  return response;
}


  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", user.token ?? '');
    AppRoutes.pushAndRemoveUntil(context, const BottomBarPage());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              const SizedBox(
                height: 22.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Let’s start here",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 34, color: kBlackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Fill in your details to begin",
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7A7A7A)),
                ),
              ),
              const SizedBox(
                height: 22.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InputField(
                        label: "Email",
                        controller: emailController,
                        bgColor: kInputBgColor,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.01,
                      ),
                      PassWordInput(
                        controller: passwordController,
                        text: "Password",
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.08,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                    _loginUser();
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("La connexion a échoué"),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  ));
                                }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF7F00), // Orange pur
                                Color(0xFFFFA726), // Orange plus clair
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.25,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: [
                          TextSpan(
                            text: "By signing in, I agree with ",
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "Terms of use\n",
                            style: TextStyle(
                              color: kBlackColor,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "and ",
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: kBlackColor,
                              fontSize: 16,
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
