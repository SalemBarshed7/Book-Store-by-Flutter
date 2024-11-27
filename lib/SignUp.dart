
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/home2.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}



class _SignUpState extends State<SignUp> {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();

 
  GlobalKey<FormState> formState  = GlobalKey();



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SIGN UP"),
        backgroundColor: Color.fromARGB(255, 64, 108, 145),
      ),
      body: 
       Container(
        // height: 1000,
        // decoration: const BoxDecoration(
          
        //   image: DecorationImage(image: AssetImage("assets/p2.png"),
        //   fit: BoxFit.cover,
          
        //   )
        // ),
        child: SingleChildScrollView(
        child: Form(
          key: formState,
         
          

          child: Column(
            children:<Widget> [
              // Container(height: 350,width: 350,
              // decoration: const BoxDecoration(
              // shape: BoxShape.circle,
              // image: DecorationImage(image: AssetImage("assets/p5.png"),
              // fit: BoxFit.cover,
              // ),),
              // ),  
              
              // SizedBox(height: 40,),

              
              TextFormField(
                

                controller: usernameController,

                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  icon: Icon(Icons.person),
                  hintText: "Enter your username",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  labelText: "Username",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 5,
                    ),
                  ),   
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return 'enter user name';
                  }
                  else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)){

                        return "please enter A-Z , a-z";
                      }
                  return null;
                } ,
                keyboardType: TextInputType.text,
              ) ,
              SizedBox(height: 20,),


              TextFormField(
                
                decoration: InputDecoration(
                  
                  icon: Icon(Icons.lock),
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: "Enter your passWord",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                  labelText: "passWord",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 5,
                    ),
                  ),   
                ),
                
                validator:(value){
                  if(value!.isEmpty){
                    return 'enter correct password';
                  }
                  
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ) ,
              SizedBox(height: 20,),

              TextFormField(
            
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email_rounded),
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: "Enter your Email",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 5,
                    ),
                  ),   
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if (value!.isEmpty){
                    return 'please enter email ';
                  }
                  else if (!value.endsWith('.com')||!value.contains('@')){

                        return "please enter correct Email";
                      }

                  
                  return null;
                },
              ) ,
              SizedBox(height: 20,),
              TextFormField(
                
              
                decoration: InputDecoration(
                  
                  icon: Icon(Icons.phone),
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: "Enter your Phone",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                  labelText: "Phone",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                  // prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 5,
                    ),
                  ),   
                ),
                validator: (value) {

                      if(value!.isEmpty){

                        return "is empty pl";
                      }
                      else if (!RegExp(r'^[0-9]+$').hasMatch(value)){

                        return "please enter correct phonenumber";
                      }

                      return null;
                    },
                keyboardType: TextInputType.phone,
              ) ,
              SizedBox(height: 20,),

              MaterialButton(
                onPressed: (){
                  if(formState.currentState!.validate()){
                    
                     String username = usernameController.text;
                     String email = emailController.text;
                   
                    // imageData _imageData, 

                  Navigator.pushAndRemoveUntil(
                    context,
                     MaterialPageRoute(builder: (context)=> HomePage(username: username, email: email,),),(route) => false, 
                     );
                  
                  }else{
                    print("error not found");
                  }
               
                  
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                
                height: 60,
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("Sign Up",
                style: TextStyle(
                  fontSize: 40,
                ),),)
        
            
              
            ],
          ),
        ),
      ),
      )
      );
  }
}






















































