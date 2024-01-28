import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/view/quiz_screen.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white,Colors.white],
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.xmark,
                  color: Colors.blue,size:28,)),
                  const CircleAvatar(minRadius: 20,
                      backgroundImage: AssetImage("lib/images/pexels-andrea-piacquadio-3777946.jpg"),
                    ),
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("lib/images/quick-quiz-6701919.png"),
              
              ),
              const SizedBox(height: 60,),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const QuizScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("Start Quiz",style: GoogleFonts.aDLaMDisplay(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                )
            ]),
          ),
        ),
      ),
    );
  }
}