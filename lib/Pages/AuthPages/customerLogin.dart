import 'package:flutter/material.dart';
import 'package:homequest/Pages/HomePages/buyerHomePage.dart';

class customerLogin extends StatefulWidget {
  const customerLogin({super.key});

  @override
  State<customerLogin> createState() => _customerLoginState();
}

class _customerLoginState extends State<customerLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color.fromARGB(255, 137, 236, 150), 
  body: Container(
    width: double.infinity,
    //color: Colors.black,
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
              
        Container( 
          margin: EdgeInsets.only(left: 90, right: 90),
          child: Text("Welcome to HomeQuest",style: TextStyle(fontFamily: 'Poppins', fontSize: 40,fontWeight: FontWeight.bold),),

        ),

        SizedBox(height: 100,),
             
        Container(
          //color: Colors.black12,
          margin: EdgeInsets.only(left: 90, right: 90),
          child: TextField(
             decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Email"
                  ),
            
          ),
        ),
        
        SizedBox(height: 15,),
        
        Container(
          //color: Colors.black12,
          margin: EdgeInsets.only(left: 90, right: 90),
          child: TextField(
             decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                  ),
            
          ),
        ),

        SizedBox(height: 15,),

        Container(
          //color: Colors.black,
          margin: EdgeInsets.only(left: 90, right: 90),

          child: SizedBox(
            width: 500,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => buyerHome()));

            },
            child: Text("Log In as Buyer",style: TextStyle(fontFamily: 'Poppins'),),
            style: ElevatedButton.styleFrom(
              elevation: 10,
            ),
            ),
          ),
        ),

     ],
     
     
     ),
   ),
    );
  }
}