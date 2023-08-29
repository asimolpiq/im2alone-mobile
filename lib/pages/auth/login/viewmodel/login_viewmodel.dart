import 'package:flutter/material.dart';

import '../login_view.dart';

abstract class LoginViewmodel extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }
}
