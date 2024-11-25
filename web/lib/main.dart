import 'package:flutter/material.dart';
import 'dart:math';
//simple BMI flutter app

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomeScreen()
    );
  }

}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState(); //call class method operation

} //Stateful Widget

class _MyHomeScreenState extends State<MyHomeScreen>
{
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double bmi=0.00;
  String bmiString="";
  String errorText="";
  String status="";

  void calculateBmi()
  {
    final double? h=double.tryParse(_heightController.value.text);
    final double? w=double.tryParse(_weightController.value.text);

    if(h==null || w==null|| h<=0 ||w<=0)
    {
      setState(() {
        errorText="Please enter your weight and height";
      });
      return;
    }

    setState(() {
      bmi=w/pow(h/100,2); //assume enter cm
      if(bmi<18.5){
        status="Underweight";
      }
      else if (bmi>=18.5 && bmi<=22.9)
        {
          status="Normal";
        }
      else if (bmi>=23 && bmi<=24.9)
        {
          status="Overweight-edge!";
        }
      else if (bmi>=25 && bmi<=29.9){
        status="Obesity-moderate!!";
      }
      else
        {
          status ="Obesity-severe!!!!!!";
        }
    });
  }//calculate bmi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('BMI Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _heightController,
                keyboardType:TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    suffixText: 'cm'
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  suffixText: 'kg',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: calculateBmi,
                    child: const Text('Calculate'),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                errorText,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade400,
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            bmiString =  bmi.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 60,
                                color:
                                status == 'Underweight' ? Colors.blue
                                    : status == 'Normal weight' ? Colors.green
                                    : status == 'Overweight-edge' ? Colors.yellow.shade700
                                    : status == 'OObesity-moderate!!' ? Colors.orange
                                    : status == 'Obesity-severe!!!!!!' ? Colors.red
                                    : null
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(status,
                                style: TextStyle(
                                    color:
                                    status == 'Underweight' ? Colors.blueGrey
                                        : status == 'Normal weight' ? Colors.green
                                        : status == 'Overweight-edge' ? Colors.yellow.shade500
                                        : status == 'Obesity-moderate!!' ? Colors.orange
                                        : status == 'Obesity-severe!!!!!!' ? Colors.red
                                        : null
                                ),
                              ),
                              const Text('BMI',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 1.0, //extend the shadow
                              offset: Offset(
                                5.0, // Move to right 5  horizontally
                                5.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 30,),
                      const Text('Nutritional Status',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 25,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(15)
                                ),
                                color: Colors.blueGrey,
                              ),
                              child: const Center(child: Text('Underweight', style: TextStyle( fontSize: 8, color: Colors.white))),

                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              color: Colors.green,
                              child: const Center(child: Text('Normal \nweight', style: TextStyle(fontSize: 8, color: Colors.white))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              color: Colors.yellow.shade700,
                              child: const Center(child: Text('Overweight-edge', style: TextStyle(fontSize: 8, color: Colors.white))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              color: Colors.orange,
                              child: const Center(child: Text('Obesity \n moderate!!', style: TextStyle(fontSize: 8, color: Colors.white))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              color: Colors.red,
                              child: const Center(child: Text('Obesity \n severe!!!!!!', style: TextStyle(fontSize: 8, color: Colors.white))),

                            ),
                          ),

                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('00', style: TextStyle(color: Colors.transparent,fontSize: 12.0)),
                          Text('18.5',style: TextStyle(fontSize: 12.0,)),
                          Text('25.0',style: TextStyle(fontSize: 12.0,)),
                          Text('30.0',style: TextStyle(fontSize: 12.0,)),
                          Text('35.0',style: TextStyle(fontSize: 12.0,)),
                          Text('40.0',style: TextStyle(fontSize: 12.0,)),
                          Text('00', style: TextStyle(color: Colors.transparent,fontSize: 12.0)),
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }


}