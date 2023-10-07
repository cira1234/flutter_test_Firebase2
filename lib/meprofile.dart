import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/login.dart';
import 'package:flutter_firebase_test/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Meprofile extends StatefulWidget {
  const Meprofile({super.key});

  @override
  State<Meprofile> createState() => _MeprofileState();
}

class _MeprofileState extends State<Meprofile> {
  Query refQ=FirebaseDatabase.instance.ref().child('users'); 

    final Future<FirebaseApp> firebase=Firebase.initializeApp();
    Profile profile=Profile(email: '', password: '', confirmpass: '', name: '');
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
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text('เข้าสู่ระบบสำเร็จ',style: TextStyle(fontSize: 25),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40,20, 40, 10),
                  child: Image.network('${userString['img']}'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,30, 235, 0),
                  child: Text('ส่วนตัว',style: TextStyle(fontSize: 18),),
                ),
                Container(
                  child: Padding( 
                    padding: const EdgeInsets.fromLTRB(40,20, 40, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        
                        fillColor: Colors.grey[100],
                        filled: true,
                        labelText: "ชื่อ : ${userString['Name']}",
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
                      decoration: InputDecoration(
                        labelText: "เบอร์โทร : ${userString['tel']}",
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


                  Padding(
                  padding: const EdgeInsets.fromLTRB(10,30, 235, 0),
                  child: Text('บัญชี',style: TextStyle(fontSize: 18),),
                ),
                Container(
                  child: Padding( 
                    padding: const EdgeInsets.fromLTRB(40,20, 40, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        
                        fillColor: Colors.grey[100],
                        filled: true,
                        labelText: "ชื่อ : ${userString['Email']}",
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
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "รหัสผ่าน : ${userString['Password']}",
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                            
                        //   ),
                        // ),
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
                      onPressed: () {

                         Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (context){
                                return login();
                               }));
                      },

                      
                      child:Text("Logout"),
                    ),
                  ),
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