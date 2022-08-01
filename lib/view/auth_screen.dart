import 'package:bookingsystem/models/http_exceptions.dart';
import 'package:bookingsystem/provider/auth.dart';
import 'package:bookingsystem/provider/guest_provider.dart';
import 'package:bookingsystem/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bookingsystem/helper/sizeHelper.dart';
import 'package:bookingsystem/helper/helper.dart';
import 'package:provider/provider.dart';
import 'package:bookingsystem/widgets/common_widgets.dart';

enum AuthMode { signUp, login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/authScreen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isObsecure = true;
  Map<String, String> _guestData = {
    'guestId': '',
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
    'email': '',
    'password': '',
  };
  final _formKey = GlobalKey<FormState>();
  final _lNameFocusNode = FocusNode();
  final _phoneNFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _confirmPasswordController = TextEditingController();
  var _isLoading = false;
  AuthMode _authMode = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    final size = SizeHelper(context);

    final fieldWidth = size.getWidth(340);
    final fieldMargin = EdgeInsets.only(top: size.getHeight(5));
    final fieldPadding = EdgeInsets.symmetric(
      horizontal: size.getWidth(10),
    );
    final containerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Theme.of(context).colorScheme.secondary,
    );
    final labelTextStyle =
        TextStyle(fontSize: size.getWidth(16), fontFamily: 'Aller');

    void _submit() async {
      if ((_guestData['firstName'] == '' ||
              _guestData['lastName'] == '' ||
              _guestData['phoneNumber'] == '' ||
              _guestData['email'] == '') &&
          _authMode == AuthMode.signUp) {
        ScaffoldMessenger.of(context)
            .showSnackBar(getSnackBar('Please fill your data'));
        return;
      }
      if (_guestData['phoneNumber']!.length < 9 &&
          _authMode == AuthMode.signUp) {
        ScaffoldMessenger.of(context)
            .showSnackBar(getSnackBar('Enter valid phone number'));

        return;
      }
      if (!_guestData['email']!.contains('@') &&
          !_guestData['email']!.contains('.com')) {
        ScaffoldMessenger.of(context)
            .showSnackBar(getSnackBar('Enter valid email'));
        return;
      }
      if (_guestData['password'] != _confirmPasswordController.text &&
          _authMode == AuthMode.signUp) {
        ScaffoldMessenger.of(context)
            .showSnackBar(getSnackBar('Password doesn\'t match'));
        return;
      }
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (_authMode == AuthMode.signUp) {
          await Provider.of<Authentication>(context, listen: false)
              .signUp(_guestData['email']!, _guestData['password']!)
              .then((value) async {
            await Provider.of<NewUser>(context, listen: false)
                .registerUser(_guestData);
          });
        } else {
          await Provider.of<Authentication>(context, listen: false)
              .login(_guestData['email']!, _guestData['password']!)
              .then((value) async{
                  await Provider.of<NewUser>(context,listen: false).fetchUserData();
          });
        }
        Navigator.of(context).pushReplacementNamed(ViewScreen.routeName);
      } on HttpException catch (error) {
        print(error.toString());
        var errorMessage = 'Authentication failed!';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage =
              'The email address is already in use by another account';
        } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
          errorMessage = 'Too many attempts now, Please try again later ';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This email is invalid, Please try with valid email';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMessage = 'This password is weak, please use strong password';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Invalid password please enter correct password';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage =
              'This E-mail is not registered, please signup and try again!';
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(getSnackBar("another type " + errorMessage));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(getSnackBar("customer error \n" + e.toString()));
      }
      setState(() {
        _isLoading = false;
      });
      // Provider.of<Authentication>(context,listen: false).signUp(_guestData['email']!,_guestData['password']!);
      // Provider.of<NewUser>(context, listen: false).registerUser(_guestData);
      // print(_guestData);
    }

    void _switchAuthMode() {
      if (_authMode == AuthMode.login) {
        setState(() {
          _authMode = AuthMode.signUp;
        });
        return;
      } else {
        setState(() {
          _authMode = AuthMode.login;
        });
        return;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: size.getHeight(20)),
              padding: EdgeInsets.only(
                  right: size.getWidth(5),
                  left: size.getWidth(5),
                  top: size.getHeight(5)),
              height: size.getHeight(209),
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        'Downtown\n   Hotel',
                        style: TextStyle(
                            fontSize: size.getWidth(47),
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Book your room with few easy steps',
                        style: TextStyle(
                            fontSize: size.getHeight(15.7),
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              height: size.getHeight(627),
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (_authMode == AuthMode.signUp) HintText('First Name'),
                    if (_authMode == AuthMode.signUp)
                      Flexible(
                        child: Container(
                          width: fieldWidth,
                          padding: fieldPadding,
                          margin: fieldMargin,
                          decoration: containerDecoration,
                          child: TextFormField(
                            maxLines: 1,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_lNameFocusNode);
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter first name',
                              icon: FieldIcon(FontAwesomeIcons.user),
                              // hintText: 'Enter first name',
                            ),
                            style: labelTextStyle,
                            onChanged: (val) {
                              _guestData['firstName'] = val;
                            },
                          ),
                        ),
                      ),
                    if (_authMode == AuthMode.signUp) HintText('Last Name'),
                    if (_authMode == AuthMode.signUp)
                      Flexible(
                        child: Container(
                          width: fieldWidth,
                          padding: fieldPadding,
                          margin: fieldMargin,
                          decoration: containerDecoration,
                          child: TextFormField(
                            focusNode: _lNameFocusNode,
                            maxLines: 1,
                            decoration: InputDecoration(
                              icon: FieldIcon(FontAwesomeIcons.user),
                              hintText: 'Enter last name',
                            ),
                            style: labelTextStyle,
                            keyboardType: TextInputType.name,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_phoneNFocusNode);
                            },
                            onChanged: (val) {
                              _guestData['lastName'] = val;
                            },
                          ),
                        ),
                      ),
                    if (_authMode == AuthMode.signUp) HintText('Phone Number'),
                    if (_authMode == AuthMode.signUp)
                      Flexible(
                        child: Container(
                          width: fieldWidth,
                          padding: fieldPadding,
                          margin: fieldMargin,
                          decoration: containerDecoration,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            focusNode: _phoneNFocusNode,
                            maxLines: 1,
                            decoration: InputDecoration(
                              icon: FieldIcon(FontAwesomeIcons.phone),
                              hintText: 'Enter phone number',
                            ),
                            style: labelTextStyle,
                            keyboardType: TextInputType.phone,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                            },
                            onChanged: (val) {
                              _guestData['phoneNumber'] = val;
                            },
                          ),
                        ),
                      ),
                    HintText('Email'),
                    Flexible(
                      child: Container(
                        width: fieldWidth,
                        padding: fieldPadding,
                        margin: fieldMargin,
                        decoration: containerDecoration,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _emailFocusNode,
                          maxLines: 1,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          decoration: InputDecoration(
                            icon: FieldIcon(FontAwesomeIcons.envelope),
                            hintText: 'Enter  email',
                          ),
                          style: labelTextStyle,
                          onChanged: (val) {
                            _guestData['email'] = val;
                          },
                        ),
                      ),
                    ),
                    HintText('Password'),
                    Flexible(
                      child: Container(
                        width: fieldWidth,
                        padding: fieldPadding,
                        margin: fieldMargin,
                        decoration: containerDecoration,
                        child: TextFormField(
                          obscureText: _isObsecure,
                          focusNode: _passwordFocusNode,
                          maxLines: 1,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_confirmPasswordFocusNode);
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObsecure = !_isObsecure;
                                  });
                                }),
                            hintText: 'Enter password',
                            icon: FieldIcon(FontAwesomeIcons.user),
                            // hintText: 'Enter first name',
                          ),
                          style: labelTextStyle,
                          onChanged: (val) {
                            _guestData['password'] = val;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.getHeight(14),
                    ),
                    if (_authMode == AuthMode.signUp)
                      Flexible(
                        child: Container(
                          width: fieldWidth,
                          padding: fieldPadding,
                          margin: fieldMargin,
                          decoration: containerDecoration,
                          child: TextFormField(
                            obscureText: true,
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocusNode,
                            maxLines: 1,
                            onFieldSubmitted: (_) {
                              // FocusScope.of(context)
                              //     .requestFocus(_lNameFocusNode);
                            },
                            decoration: InputDecoration(
                              hintText: 'Confirm password',
                              icon: FieldIcon(FontAwesomeIcons.user),
                              // hintText: 'Enter first name',
                            ),
                            style: labelTextStyle,
                            onChanged: (val) {

                            },
                          ),
                        ),
                      ),
                    SizedBox(
                      height: size.getHeight(8),
                    ),
                    if (_isLoading)
                      CircularIndicator()
                    else
                      Flexible(
                        fit: FlexFit.loose,
                        child: Center(
                          heightFactor: 1,
                          child: Container(
                            // padding: fieldPadding,
                            height: size.getHeight(45),
                            width: _authMode == AuthMode.signUp
                                ? size.getWidth(95)
                                : size.getWidth(80),
                            child: ElevatedButton(
                              onPressed: _submit,
                              child: Text(
                                (_authMode == AuthMode.login)
                                    ? 'Login'
                                    : 'Sign up',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: size.getWidth(16),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans'),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: size.getHeight(8),
                    ),
                    if (_isLoading)
                      CircularIndicator()
                    else
                      Flexible(
                          child: Center(
                        heightFactor: 1,
                        child: Container(
                          child: TextButton(
                            child: Text(
                              (_authMode == AuthMode.signUp)
                                  ? 'Already have account '
                                  : 'Sign up',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: size.getWidth(16),
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: _switchAuthMode,
                          ),
                        ),
                      )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Center(
            child: const CircularProgressIndicator(
          color: Colors.white,
        )));
  }
}

class FieldIcon extends StatelessWidget {
  late final IconData icon;
  FieldIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    final size = SizeHelper(context);
    return Icon(
      icon,
      color: Theme.of(context).colorScheme.primary,
      size: size.getWidth(22),
    );
  }
}
