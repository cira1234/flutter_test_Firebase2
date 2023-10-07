// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_test/dialog.dart';
// import 'package:flutter_firebase_test/login.dart';
// import 'package:flutter_firebase_test/profile.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_field_validator/form_field_validator.dart';

// class Register extends StatefulWidget {
//   const Register ({super.key});

//   @override
//   State<Register > createState() => _RegisterState();
// }

// class _RegisterState extends State<Register > { 
//     final Future<FirebaseApp> firebase=Firebase.initializeApp();
//     Profile profile=Profile(email: '', password: '');

//     final formKey=GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: firebase, 
//       builder: (context,snapshot) {
//         if(snapshot.hasError){
//           return Scaffold(
//             appBar: AppBar(title: Text("Error")),
//             body: Center(child: Text("${snapshot.error}"),),
//           );
//         }
//         if(snapshot.connectionState==ConnectionState.done){
//            return Scaffold(
//       appBar: AppBar(
//         title: Text("Register"),
//       ),
//       body: Container(
//         child: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   child: Padding( 
//                     padding: const EdgeInsets.fromLTRB(20,50, 20, 0),
//                     child: TextFormField(
//                       validator: MultiValidator([
//                         RequiredValidator(errorText: "Please input Password"),
//                         EmailValidator(errorText: "Email format not correct")
//                       ]
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                       onSaved: (String? email){  
//                         profile.email=email!;
//                       },
//                       decoration: InputDecoration(
                        
//                         labelText: "Email",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)
//                         )
//                       ),
//                     ),
//                   ),
//                 ),
//                 //newpassword
//                 Container(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(20,20, 20, 0),
//                     child: TextFormField(
//                       validator: RequiredValidator(errorText: "Please input Password"),
//                       obscureText: true,
//                         onSaved: (String? password){  
//                         profile.password=password!;
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)
//                         )
//                       ),
//                     ),
//                   ),
//                 ),
//                 //comfirm password
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0,30,0, 0),
//                   child: Container(
//                     height: 45,
//                     width: 360,
//                     child: ElevatedButton(
//                       onPressed: () async{
                    
//                         if(formKey.currentState!.validate()){
//                           formKey.currentState?.save();
//                            print("email=${profile.email} password=${profile.password}");
//                          try{
//                             await  FirebaseAuth.instance.createUserWithEmailAndPassword(
//                             email:  profile.email , 
//                             password: profile.password
//                             ).then((value){
//                                formKey.currentState?.reset();
//                                Mydialog().nomalDialog(context,'สร้างบัญชีผู้ใช้เรียบร้อย');
//                                Navigator.pushReplacement(context,
//                                MaterialPageRoute(builder: (context){
//                                 return login();
//                                }));
//                             });
                              
                          
//                          }
//                          on FirebaseAuthException catch(e){
//                             print(e.code);
//                             String message="";
//                             if(e.code=='email-already-in-use'){
//                                 message="มีอีเมลล์นี้ในระบบแล้ว กรุณาใช้อีเมลอื่น";
//                             }
//                             else if(e.code=="weak-password"){
//                               message="รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษร";
//                             }
//                             Fluttertoast.showToast(
//                               msg: "${message}",
//                               gravity: ToastGravity.TOP
//                             );
//                          }
//                         }

//                       },
//                       child:Text("Register"),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//         }
//         return Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//     });
   
//   }
// }