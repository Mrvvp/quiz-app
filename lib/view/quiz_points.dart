import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/view/homepage.dart';
class QuizPoints extends StatelessWidget {
  final int points;

  const QuizPoints({Key? key, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network("https://lottie.host/23d58deb-541f-49a3-9fb0-74afb51e4406/LiTFIVh6Ze.json",width: 150),
            SizedBox(height: 20,),
            Text(
              'Your Score',
              style: GoogleFonts.aDLaMDisplay(
                fontSize: 30,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Text(
                '$points',
                style: GoogleFonts.aDLaMDisplay(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50,),
            GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("Try Again",style: GoogleFonts.aDLaMDisplay(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
