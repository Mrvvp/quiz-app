import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/view/api_services.dart';
import 'package:quiz_app/view/quiz_points.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
 var currentQuestionIndex = 0;
 int seconds = 60;
 Timer?timer;
 late Future quiz;

 int points =0;


 var isLoaded = false;

 var optionList = [];

 var optionColor = [
  Colors.blue,
  Colors.blue,
  Colors.blue,
  Colors.blue,
  ];
 
  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }
  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }
  
 
  
  startTimer() {
  timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    setState(() {
      if (seconds > 0) {
        seconds--;
      } else {
        isLoaded = false;
        currentQuestionIndex++;
        timer.cancel();
        seconds = 60;
        startTimer();
      }
    });
  });
}


    resetColors(){
      optionColor = [
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.blue,
  ];
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: quiz, 
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){

               var data = snapshot.data["results"];
                if(isLoaded == false){
                  optionList = data[currentQuestionIndex]["incorrect_answers"];
                  optionList.add(data[currentQuestionIndex]["correct_answer"]);
                  optionList.shuffle();
                  isLoaded = true ;
                  }
                return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(CupertinoIcons.xmark,
                    color: Colors.blue,size:28,)),
                    Stack(
                      alignment: Alignment.center,
                      children: [Text("$seconds",style: GoogleFonts.aDLaMDisplay(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        value: seconds/60,
                        valueColor: const AlwaysStoppedAnimation(Colors.blue),
                      ),
                    )
                    ]),
                    const CircleAvatar(minRadius: 20,
                      backgroundImage: AssetImage("lib/images/pexels-andrea-piacquadio-3777946.jpg"),
                    ),
                 ],),
                 const SizedBox(height:10),
                 Image.asset("lib/images/Screenshot 2024-01-26 003705b.png",width: 150,),
                 
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Align(alignment: Alignment.centerLeft,
                               child: Text("> Question  ${currentQuestionIndex + 1} of ${data.length}" ,style: GoogleFonts.aDLaMDisplay(fontSize: 15,color: Colors.blue))),
                 ),
              
                 Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: Text(data[currentQuestionIndex]["question"] ,style: GoogleFonts.aDLaMDisplay(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold)),
                 ),
                 const SizedBox(height: 20,),
                 ListView.builder(
                  shrinkWrap: true,
                  itemCount: optionList.length,
                  itemBuilder: (BuildContext context, int index){
                    var answer = data[currentQuestionIndex]["correct_answer"];
                    return GestureDetector(onTap: (){
                     setState(() {
                        if(answer.toString() == optionList[index].toString()){
                        optionColor[index] = Colors.green;
                        points = points+10 ;
                      }else {
                        optionColor[index] = Colors.red;
                      }
                if (currentQuestionIndex < data.length -1 ) {
                       Future.delayed(Duration(seconds: 1), () {
                       setState(() {
                           isLoaded = false;
                           currentQuestionIndex++;
                           resetColors();
                           timer!.cancel();
                           seconds = 60;
                           startTimer();
                           });
                           });
                           }else {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => QuizPoints(points: points)),
                             );
                            }
                       
              
                    });
                    },
                  
                       child: Container(
                        margin: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                          color: optionColor[index],
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(alignment: Alignment.centerLeft
                            ,child: Text(optionList[index].toString() ,style: GoogleFonts.aDLaMDisplay(fontSize: 20,color: Colors.white))),
                        ),
                      ),
                    );
                  })
              ],),
            ),
          );
              }else{
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ));
              }
              
              
            }
            
            
            )
        )
      ),
    );
  }
}