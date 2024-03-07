import 'package:flutter/material.dart';
import 'login.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});
  @override
  _homepageState createState() => _homepageState();
}
class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(

        primary: Colors.yellow[700],
        secondary: Colors.yellow.shade700,

      ),
    );
    return  Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Mobile Diabetic App'),
          centerTitle: true,
        ),
        drawer:Drawer(
          backgroundColor: Colors.blue,
            child:Padding(
              padding: EdgeInsets.fromLTRB(0,50,0,0),
              child: Column(
                children: [
                  Text('Menu',style:TextStyle(fontSize: 37.5,color: Colors.white)),
                  Container(width: 500,color: Colors.white,margin: EdgeInsets.fromLTRB(0, 10, 0, 10),child: TextButton(onPressed: (){}, child: Text("Ml Model",style: TextStyle(color: Colors.black,fontSize: 18,),),)),
                  Container(width: 500,color: Colors.white,margin: EdgeInsets.fromLTRB(0, 10, 0, 10),child: TextButton(onPressed: (){}, child: Text("Thermography DL",style: TextStyle(color: Colors.black,fontSize: 18,),),)),
                  Container(width: 500,color: Colors.white,margin: EdgeInsets.fromLTRB(0, 10, 0, 10),child: TextButton(onPressed: (){}, child: Text("Retinography DL",style: TextStyle(color: Colors.black,fontSize: 18,),),)),
                  Container(width: 500,color: Colors.red,margin: EdgeInsets.fromLTRB(0, 450, 0, 10),child: TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));}, child: Row(children:[Icon(Icons.logout,color: Colors.white),Text("                    Logout",style: TextStyle(color: Colors.white,fontSize: 18,),),],),)),
                ],
              ),
            ),
        ),
        body: SingleChildScrollView(
          child: Column(
              children:[
                const Padding(
                  padding: EdgeInsets.fromLTRB(150,25,0,60),
                  child: Text('Home',style:TextStyle(fontSize: 37.5,fontWeight: FontWeight.bold)),
                ),

              ]
          ),
        )
    );
  }
}
