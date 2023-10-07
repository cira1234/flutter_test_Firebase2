// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_test/dialog.dart';
// import 'package:flutter_firebase_test/login.dart';
// import 'package:flutter_firebase_test/meprofile.dart';
// import 'package:flutter_firebase_test/profile.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:image_picker/image_picker.dart';

// class Register extends StatefulWidget {
//   const Register ({super.key});

//   @override
//   State<Register > createState() => _RegisterState();
// }

// class _RegisterState extends State<Register > { 

//     final Future<FirebaseApp> firebase=Firebase.initializeApp();
//    final formKey=GlobalKey<FormState>();
//    Profile profile=Profile(email: '', password: '', confirmpass: '', name: '');
//  late File image;
//     late DatabaseReference dbRef;
//   @override
//     void initState(){
//       super.initState();
//       dbRef=FirebaseDatabase.instance.ref().child('users');
//     }
//       PlatformFile? file;
//       String selectFileName='';
//       String defaultimg='lib/logo/add.jpg';
//       UploadTask? uploadTask;
//       String? imageUrl='';
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
//       body: Container(
//         child: Form(
//            key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(40,100, 40, 10),
//                   child: Image.asset('lib/logo/logoimg.png'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10,30, 235, 0),
//                   child: Text('สมัครสมาชิก',style: TextStyle(fontSize: 18),),
//                 ),
//                 Container(
//                   child: Padding( 
//                     padding: const EdgeInsets.fromLTRB(40,20, 40, 0),
//                     child: TextFormField(
//                       validator: RequiredValidator(errorText: "กรุณากรอกUsername"),
//                           onSaved: (String? email){  
//                         profile.email=email!;
//                       },
//                       decoration: InputDecoration(
                        
//                         fillColor: Colors.grey[100],
//                         filled: true,
//                         labelText: "Username",
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey.shade100),
//                           borderRadius: BorderRadius.circular(10)
//                         )
//                       ),
//                     ),
//                   ),
//                 ),
//                 //newpassword
//                 Container(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(40,10, 40, 0),
//                     child: TextFormField(
//                       validator: RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
//                       obscureText: true,
//                              onSaved: (String? password){  
//                         profile.password=password!;
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         fillColor: Colors.grey[100],
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey.shade100),
//                           borderRadius: BorderRadius.circular(10)
//                         )
//                       ),
//                     ),
//                   ),
//                 ),


//                  Container(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(40,10, 40, 0),
//                     child: TextFormField(
//                         onSaved: (String? confirmpass){  
//                         profile.confirmpass=confirmpass!;
//                       },
//                        validator: RequiredValidator(errorText: "กรุณายืนยันรหัสผ่าน"),
//                       obscureText: true,
                  
                  
//                       decoration: InputDecoration(
//                         labelText: "Confirm Password",
//                        fillColor: Colors.grey[100],
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey.shade100),
//                           borderRadius: BorderRadius.circular(10)
//                         )
//                       ),
//                     ),
//                   ),
//                 ),


//                  Container(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(40,10, 40, 0),
//                     child: TextFormField(
//                       validator: RequiredValidator(errorText: "กรุณาใส่ชื่อ-สกุล"),
//                       onSaved: (String? name){  
//                         profile.name=name!;
//                       },
//                       decoration: InputDecoration(
//                         labelText: "ชื่อ-สกุล",
//                         fillColor: Colors.grey[100],
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey.shade100),
//                           borderRadius: BorderRadius.circular(10)
//                         )
//                       ),
//                     ),
//                   ),
//                 ),
    
                

//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
//                    child: Container(
//                     width: 400,
//                     height: 120,
//                     child:   IconButton(
//                             iconSize: 100,
//                             icon: const Icon(
//                               Icons.add,
//                             ),
//                         onPressed:()async{
//                           String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
//                           ImagePicker imagePicker=ImagePicker();
//                           XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
//                           print('${file?.path}');
//                           Reference referenceRoot=FirebaseStorage.instance.ref();
//                           Reference referenceDirImages=referenceRoot.child('images');
//                           Reference referenceImageToUpload=referenceDirImages.child(uniqueFileName);
                          
//                           try{
//                             await referenceImageToUpload.putFile(File(file!.path));
//                             imageUrl=await referenceImageToUpload.getDownloadURL();
//                           }
//                           catch(e){

//                           }

//                         }
                        
//                     ),
//                    ),
//                  ),
//                 //comfirm password
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(40,20,40, 0),
//                   child: Container(
//                     height: 45,
//                     width: 360,
//                     child: ElevatedButton(
//                       onPressed:(){

                    
//                    if(formKey.currentState!.validate()){
                               
//                                formKey.currentState?.save();
//                             print("email=${profile.email}password=${profile.password}confirmpassword=${profile.confirmpass}name=${profile.name}");
//                             Map<String,String> user={
//                               'Email':profile.email,
//                               'Password':profile.password,
//                               'ConfirmPassword':profile.confirmpass,
//                               'Name':profile.name,
//                               'img':imageUrl.toString()
                            
//                             };
//                              dbRef.push().set(user);
//                                Navigator.pushReplacement(context,
//                                MaterialPageRoute(builder: (context){
//                                 return Meprofile();
//                                }));
//                           }
                       
                 
                        
//                     },
//                       child:Text("สมัครสมาชิก"),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(90, 20, 0, 0),
//                       child: Text('คุณมีบัญชีผู้ใช้งานอยู่แล้ว?'),
//                     ),
//                         InkWell(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 20, 50, 0),
//                         child: Text('เข้าสู่ระบบ',style: TextStyle(color: Colors.blue),),
//                       ),
//                       onTap: ()=>{
//                           Navigator.pushReplacement(context,
//                                MaterialPageRoute(builder: (context){
//                                 return login();
//                                })),
                               
//                       },
//                     )
//                   ],
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