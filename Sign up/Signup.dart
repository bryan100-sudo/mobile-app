import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(  
        appBar: AppBar(title: Text('Sign Up'),),
        body: SignUp(),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Password Visibility
  bool _passwordVisibility = true;
  bool _passwordVisibility2 = true;


  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String _email;
  String _password;


  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      confirmation();

    }
  }

  void confirmation() {
    final snackbar = new SnackBar(
      content: new Text('Email : $_email' + '\n' + 'password : $_password'),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
      image: AssetImage('files/back.jpg'),
      fit: BoxFit.cover,
    ),
  ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      key: scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Form(
          key: formKey, 
          child: Column(
          children: <Widget>[

          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Already Have An Account? ', style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: 'Click Here!',
                  style: TextStyle(color: Colors.lightBlueAccent, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){}
                  )
                ],
              ),
            ),
        
        //Email
            SizedBox(
              height: 40,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration:
                InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  hintText: "Email"),
              validator: (val){
                if (val.isEmpty)
                  return 'Empty';
                if(!val.contains('@'))
                  return 'Invalid Email';
                

                return null;
              },
              onSaved: (val) => _email = val,
            ),

            SizedBox(
              height: 20,
            ),

            //Password
            TextFormField(
              controller: _pass,
              obscureText: _passwordVisibility,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(11),
                FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: "Contact Number",
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisibility ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                       _passwordVisibility = !_passwordVisibility;
                      });
                    },
                  )),
              validator: (val){
                if(val.isEmpty)
                  return 'Empty';
                if(val.length < 11)
                  return 'Password too Short';
                if(!val.contains('09'))
                  return ('Invalid Number');
                  
                return null;
              },
            ),

            SizedBox(
              height: 20,
            ),

            //Confirm Password
          TextFormField(
            controller: _confirmPassword,
            obscureText: _passwordVisibility2,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(11),
              FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: "Confirm Contact Number",
              suffixIcon: IconButton(
                icon: Icon(
                 _passwordVisibility2 ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _passwordVisibility2 = !_passwordVisibility2;
                  });},)
                ),
              validator: (val){
                if(val.isEmpty)
                  return 'Empty';
                if(val.length < 11)
                  return 'Password too Short';
                if(val != _pass.text)
                  return 'Passwords Mismatch';
                return null;
              },
              onSaved: (val) => _password = val,
            ),

            SizedBox(
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 4, 6),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Note: Your Contact Number is your Password',
                  style: TextStyle(color: Colors.red),),),
              
              ),
              height: 30,
            ),

          SizedBox(
            height: 30,
          ),
          SizedBox(
            child: Padding(
              padding: EdgeInsets.only(left: 210),

            child:  RaisedButton(
            child: Text(
              'Next',
              style: new TextStyle(color: Colors.white),),
              color: Colors.blue,
              highlightColor: Colors.orangeAccent,
              onPressed: _submit,
            ),
          ),
        )        
      ],
    ),)
  ),   
   ),
   );
}}

