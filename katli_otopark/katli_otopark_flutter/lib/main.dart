import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katli_otopark_flutter/db/db_helper.dart';
import 'package:katli_otopark_flutter/otopark.dart';
import 'package:katli_otopark_flutter/screens/kayitlar.dart';

import 'controllers/arabagirisi_controller.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
} 
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //FireBase Başlatmak

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return LoginScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{

      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code =="kullanıcı bulunamadı"){
        print("Bu ID'de bir kullanıcı bulunamadı");
      }
    }

    return user;
  }


  @override
  Widget build(BuildContext context) {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
   final _taskController = Get.put(TaskController());
  
  

    return Scaffold(
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 250,
                child: Image.asset("assets/logo.png"),
              ),
            ),
            const Text("OTOPARK",
            style: TextStyle(
              color: Color(0xFFD40700),
              fontSize: 28.0,
              fontWeight: FontWeight.bold
            ),
            ),
            const Text("GİRİŞ",
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFFD40700),
              fontWeight: FontWeight.bold
            ),
            ),
            const SizedBox(height: 45.0,
            ),
             TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Lütfen Geçerli Bir E-mail Adresi Giriniz",hintStyle: TextStyle(color: Colors.black),
                labelText: "E-Mail",labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD40700))
                ),
                prefixIcon: Icon(Icons.person,color: Colors.black,),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextFormField(
          controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Şifre",labelStyle: TextStyle(color: Colors.black),hintStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD40700))
                ),
                hintText: "Lütfen Şifrenizi Giriniz",
                prefixIcon: Icon(Icons.lock,color: Colors.black,),
              ),
            ),
      const    SizedBox(height: 50,
            ),

            Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: const Color( 0xFFD40700),
              onPressed: () async{

              User? user  = await  loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
              print(user);
              if(user !=null){
                _taskController.getTasks();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> OtoparkScreen()));
              }
              },
              child: const Text("Giriş ",style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              )
              )

          ],
      ),
        ),
      ),
    );
  
  }
  
  }