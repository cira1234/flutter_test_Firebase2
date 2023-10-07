import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/dialog.dart';
import 'package:flutter_firebase_test/meprofile.dart';
import 'package:flutter_firebase_test/profile.dart';
import 'package:flutter_firebase_test/register1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class login extends StatefulWidget {
  const login ({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> { 
    final Future<FirebaseApp> firebase=Firebase.initializeApp();
    Profile profile=Profile(email: '', password: '', confirmpass: '', name: '');
    Query refQ=FirebaseDatabase.instance.ref().child('users'); 
    final formKey=GlobalKey<FormState>();


    Widget lisItem({required Map userString}){
  return Container(
      child: Container(
        child: Form(
           key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40,200, 40, 10),
                  child: Image.asset('lib/logo/logoimg.png'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,30, 235, 0),
                  child: Text('เข้าสู่ระบบ',style: TextStyle(fontSize: 18),),
                ),
                Container(
                  child: Padding( 
                    padding: const EdgeInsets.fromLTRB(40,20, 40, 0),
                    child: TextFormField(
                      validator: RequiredValidator(errorText: "กรุณากรอกUsername"),
                          onSaved: (String? email){  
                        profile.email=email!;
                      },
                      decoration: InputDecoration(
                        
                        fillColor: Colors.grey[100],
                        filled: true,
                        labelText: "Username",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ),
                ),
                //newpassword
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40,10, 40, 0),
                    child: TextFormField(
                      validator: RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                      obscureText: true,
                             onSaved: (String? password){  
                        profile.password=password!;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.grey[100],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ),
                ),
                //comfirm password
                Padding(
                  padding: const EdgeInsets.fromLTRB(40,30,40, 0),
                  child: Container(
                    height: 45,
                    width: 360,
                    child: ElevatedButton(
                      onPressed: () async{
                    
                        if(formKey.currentState!.validate()){
                          formKey.currentState?.save();
                          if(profile.email!=userString['Email'] ){
                               Mydialog().nomalDialog(context,'username ไม่ถูกต้อง${userString['Email']}');
                          }
                          else if(profile.password!=userString['Password']){
                              Mydialog().nomalDialog(context,'รหัสผ่าน ไม่ถูกต้อง');
                          }
                          else if(profile.email!=userString['Email'] && profile.password!=userString['Password'] ){
                              Mydialog().nomalDialog(context,'กรุณาใส่ username และ รหัสผ่าน ให้ถูดต้อง');
                          }
                     
                     else{
                         Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (context){
                                return Meprofile();
                               }));
                     }
                             
                          
                        
                        }

                      },
                      child:Text("Login"),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
                      child: Text('คุณยังไม่มีบัญชีผู้ใช้งาน ?'),
                    ),
                        InkWell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 50, 0),
                        child: Text('สมัครสมาชิก',style: TextStyle(color: Colors.blue),),
                      ),
                      onTap: ()=>{
                          Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (context){
                                return Register();
                               })),
                               
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase, 
      builder: (context,snapshot) {
        if(snapshot.hasError){
          return Scaffold(
            appBar: AppBar(title: Text("Error")),
            body: Center(child: Text("${snapshot.error}"),),
          );
        }
        if(snapshot.connectionState==ConnectionState.done){
            return Scaffold(
      body: SafeArea(
        child:FirebaseAnimatedList(query: refQ, itemBuilder: (context, snapshot, animation, index) {
          Map userString=snapshot.value as Map;
        return  lisItem(userString: userString);
        }, ),
      ),
    );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    });
   
  }

}


