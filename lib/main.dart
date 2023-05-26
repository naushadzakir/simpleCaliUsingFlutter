import 'package:flutter/material.dart';
import 'sizeConfig.dart';
import 'package:math_expressions/math_expressions.dart';
void main()
{
  runApp(Calculator()); 
}
class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation ="0";
  String result= "0";
  String expression= "";
  double equationFontSize= 38.0;
  double resultFontSize= 48.0;

  buttonPressed(String buttonText)
  {
    setState(() {
      if(buttonText=="C"){
        equation="0";
        result="0";
        equationFontSize= 38.0;
        resultFontSize= 48.0;
      }
      else if(buttonText=="⌫"){
        equationFontSize= 48.0;
        resultFontSize= 38.0;
        equation= equation.substring(0, equation.length-1);
        if(equation==""){
          equation= "0";
        }
      }
      else if(buttonText=="="){
        equationFontSize= 48.0;
        resultFontSize= 38.0;

        expression= equation;

        try{
          Parser p = new Parser();
          Expression exp= p.parse(expression);

          expression = equation;
          expression = expression.replaceAll('×', "/");
          expression = expression.replaceAll('÷', "/");
          
          ContextModel cm= ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          print(e);
          result= "Error";

        }
      }


      else{
        equationFontSize= 48.0;
        resultFontSize= 38.0;
        if(equation=="0")
          {
            equation=buttonText;
          }
        else{
          equation= equation+buttonText;
        }
      }
    });
  }


  Widget buildButton(String buttonText, double buttonHeight,double buttonWidth,Color buttonColor)=> Container(
        height: SizeConfig.blockSizeVertical*5*buttonHeight,
        width: SizeConfig.safeBlockHorizontal*5*buttonWidth,
        child: ElevatedButton(
          onPressed: ()=> buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
             foregroundColor: Colors.black,
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                    color: Colors.black,
                    width: 1,
                  )
              )
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.3,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        )
    );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(equation , style: TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(result, style: TextStyle(fontSize:resultFontSize),),
          ),
          
          Expanded(
              child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width:SizeConfig.blockSizeHorizontal*75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 2, 2, Colors.redAccent),
                        buildButton("⌫", 2, 2, Colors.blue),
                        buildButton("÷", 2, 2, Colors.blue),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 2, 2, Colors.grey),
                          buildButton("8", 2, 2, Colors.grey),
                          buildButton("9", 2, 2, Colors.grey),
                        ]
                     ),
                    TableRow(
                        children: [
                          buildButton("4", 2, 2, Colors.grey),
                          buildButton("5", 2, 2, Colors.grey),
                          buildButton("6", 2, 2, Colors.grey),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1", 2, 2, Colors.grey),
                          buildButton("2", 2, 2, Colors.grey),
                          buildButton("3", 2, 2, Colors.grey),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 2, 2, Colors.grey),
                          buildButton("0", 2, 2, Colors.grey),
                          buildButton("00", 2, 2, Colors.grey),
                        ]
                    )
                  ],
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal*25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 2, 2, Colors.blue),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 2, 2, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 2, 2, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 4, 2, Colors.blue),
                        ]
                    )
                  ],
                ),
              )
            ],
          ),


        ],
      ),
    );
  }
}

