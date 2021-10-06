import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auth_animation/constants.dart';
import 'package:flutter_auth_animation/widgets/login_form.dart';
import 'package:flutter_auth_animation/widgets/sign_up_form.dart';
import 'package:flutter_auth_animation/widgets/socal_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation(){
    _animationController = AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView(){
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, snapshot) {
          return Stack(
            children: [
              //Login
              AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,//88%
                  height: _size.height,
                  left: _isShowSignUp ? -_size.width * 0.76 : -_size.width * 0,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  )
              ),
              //Sign Up
              AnimatedPositioned(
                  duration: defaultDuration,
                  height: _size.height,
                  width: _size.width * 0.88,
                  left: _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
              ),
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                top: _size.height * 0.1, //10% da altura
                left: 0,
                right: _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white60,
                  child: AnimatedSwitcher(
                    duration: defaultDuration,
                    child: SvgPicture.asset(
                      "assets/animation_logo.svg"
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  bottom: _size.height * 0.1,
                  right: _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                  child: SocalButtns()
              ),
              //Texto de Login
              AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: _isShowSignUp
                      ? _size.height / 2 -80
                      : _size.height * 0.3,
                  left: _isShowSignUp
                      ? 0
                      : _size.width * 0.44 -80,//metade de 0.88 definido acima
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: _isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.white : Colors.white70,
                      ),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: (){
                          if(_isShowSignUp){
                            updateView();
                          }else{
                            //logica do login
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                          width: 160,
                          child: Text(
                            "Entrar".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              //Texto de Cadastro
              AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: !_isShowSignUp
                      ? _size.height / 2 -80
                      : _size.height * 0.3,
                  right: _isShowSignUp
                      ? _size.width * 0.44 -80
                      : 0,//metade de 0.88 definido acima
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: !_isShowSignUp ? 20 : 28,
                      fontWeight: FontWeight.bold,
                      color: _isShowSignUp ? Colors.white : Colors.white70,
                    ),
                    child: Transform.rotate(
                      angle: (90 - _animationTextRotate.value) * pi / 180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          if(_isShowSignUp){
                            //logica de cadastro
                          }else{
                            updateView();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                          width: 160,
                          child: Text(
                            "Cadastro".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  )
              ),
            ],
          );
        }
      ),
    );
  }
}
