import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialnetworkplatform/Models/UserSQL.dart';

import '../Singleton.dart';
import 'LoginScreen.dart';


class RegisterScreen extends StatelessWidget {

  String _email;
  String _password;
  String _confirmPassword;
  String _name;
  String _surname;
  String _bio;
  String _dateOfBirth;
  DateTime dateofBirth;
  RegisterResult result;
  RegisterScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Connect", style: Theme.of(context).textTheme.headline1),
                ],
              ),
              SizedBox(
                //Use of SizedBox
                height: 80,
              ),
              Container(
                  constraints: BoxConstraints.loose(Size.square(800)),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: Colors.black),
                      left: BorderSide(
                          color: Colors.black),
                      right: BorderSide(),
                      bottom: BorderSide(),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            //Use of SizedBox
                            height: 35,
                          ),
                          Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 40
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  hintText: 'Enter Your Email'
                              ),
                              onChanged: (newValue) => {
                                _email = newValue
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  hintText: 'Enter Your Password'
                              ),
                              onChanged: (newValue) => {
                                _password = newValue
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Confirm Password',
                                  hintText: 'Enter Your Password Again'
                              ),
                              onChanged: (newValue) => {
                                _confirmPassword = newValue
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                  hintText: 'Enter Your Name'
                              ),
                              onChanged: (newValue) => {
                                _name = newValue
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Surname',
                                  hintText: 'Enter Your Surname'
                              ),
                              onChanged: (newValue) => {
                                _surname = newValue
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Bio',
                                  hintText: 'Enter Your Bio Description'
                              ),
                              onChanged: (newValue) => {
                                _bio = newValue
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'DateOfBirth (DD-MM-YYYY)',
                                  hintText: 'Enter Your Date Of Birth'
                              ),
                              onChanged: (newValue) => {
                                _dateOfBirth = newValue
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 10,
                      ),
                      FloatingActionButton.extended(
                        label: Text("Register"),
                        icon: Icon(Icons.app_registration),
                        backgroundColor: Colors.green,
                        focusColor: Colors.grey,
                        onPressed: () async => {
                          result = await Register(),
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(result.Success ? "Success" : "Error"),
                                content: Text(result.Message),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              )
                          ),
                          if(result.Success){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MaterialApp(
                                  home: LoginScreen())),
                            ),
                          },
                        },
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 10,
                      ),
                      InkWell(
                          child: new Text('Already have an account?'),
                          highlightColor: Colors.red,
                          hoverColor: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MaterialApp(
                                home: LoginScreen())),
                          )
                      )

                    ],
                  )
              )
            ],
          ),
        )
    );
    }
  Future<RegisterResult> Register() async{

    try{
      print(_dateOfBirth);
      dateofBirth = new DateFormat("dd-MM-yyyy").parse(_dateOfBirth);
    } catch(e){
      print(e);
      return RegisterResult(false, "Not valid date format");
    }
    if(_password != _confirmPassword){
      return RegisterResult(false, "Failed to confirm password");
    }
    var userToInsert = new UserSQL("",_name,_surname,dateofBirth,_email,_password,_bio,"");
    var response = await Singleton.socialNetworkRepo.RegisterUser(userToInsert);
    if(!response.Success)
    {
      return RegisterResult(false, response.ErrorMessage);
    }

    return RegisterResult(true, "User created successfully!");
  }

}
class RegisterResult{
  bool Success;
  String Message;
  RegisterResult(this.Success,this.Message);
}