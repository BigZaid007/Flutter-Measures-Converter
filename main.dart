import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: testApp(),
    );
  }
}

class testApp extends StatefulWidget {
  @override
  _testAppState createState() => _testAppState();
}

class _testAppState extends State<testApp> {
  @override
  double _userInput;
  String _convertedMeasure;
  String errorMessage;
  String _startValue;
  var fromUnits = [
    'Meters',
    'Kilometer',
    'Grams',
    'Kilograms (kg)',
    'Feet',
    'Miles',
    'Pounds (lbs)',
    'ounces'
  ];

  final Map<String,int> measuresMap ={
    'Meters':0,
    'Kilometer':1,
    'Grams':2,
    'Kilograms (kg)':3,
    'Feet':4,
    'Miles':5,
    'Pounds (lbs)':6,
    'ounces':7
  };

  dynamic formulas ={

    '0':[1,0.001,0,0,3.280,0.0006213,0],
    '1':[1000,1,0,0,3280.84,0,6213,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220,0.03],
    '3':[0,0,1000,1,0,0,2.2046,35.274],
    '4':[0.0348,0.00030,0,0,1,0.000189],
    '5':[1609.34,1.60934,0,05280,1,0,0],
    '6':[0,0,453.592,0.4535,0,0,1,16],
    '7':[0,0,28.3495,0.02834,3.28084,0,0.1]
  };


  void converter (double value,String from,String to)
  {

    int nFrom=measuresMap[from];
    int nTo=measuresMap[to];
    var multiplier=formulas[nFrom.toString()][nTo];
    var result=value * multiplier;

    if(result==0)
      {
        errorMessage='Cannot Performed This Conversion';
      }
    else
      {
        errorMessage='${_userInput.toString()} $_startValue are ${result.toString()} $_convertedMeasure';
      }
    setState(() {
      errorMessage=errorMessage;
    });

  }


  void initState() {
    _userInput = 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Text('Measures',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 50,color: Colors.white),),
                Text('Converter!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 50,color: Colors.white),),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: TextField(
                    style: TextStyle(fontSize: 20,color: Colors.white),
                    decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[400],
                    hintText: 'Enter Your Value',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),

                    ),

                  ),
                  onChanged: (text){

                    var input=double.tryParse(text);
                    if(input!=null)
                      {
                        setState(() {
                          _userInput=input;
                        });
                      }
                  },

                  ),
                ),
                SizedBox(height: 10,),

                Text('From',style: TextStyle(fontSize: 20,color: Colors.white),),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadiusDirectional.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(

                        


                        hint: Text('Choose Your Unit',style: TextStyle(color: Colors.amber),),

                         dropdownColor: Colors.black,
                        isExpanded: true,style: TextStyle(
                        fontSize: 20,color: Colors.amber
                      ),   items: fromUnits.map((String value) {
                        return DropdownMenuItem<String>(

                            value: value,
                            child: Text(value),);
                      } ).toList(),
                      onChanged: (String value){
                          setState(() {

                            _startValue=value;

                          });
                      },
                        value: _startValue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text('To',style: TextStyle(fontSize: 20,color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadiusDirectional.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(

                        hint: Text('Choose Your Unit',style: TextStyle(color: Colors.amber),),

                        dropdownColor: Colors.black,
                        isExpanded: true,style: TextStyle(
                          fontSize: 20,color: Colors.amber
                      ),   items: fromUnits.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),);
                      } ).toList(),
                        onChanged: (String value){
                          setState(() {

                            _convertedMeasure=value;

                          });
                        },
                        value: _convertedMeasure,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: FlatButton(
                    onPressed: (){
                      if(_startValue.isEmpty || _convertedMeasure.isEmpty || _userInput==0)
                        return;
                      else {
                        converter(_userInput, _startValue, _convertedMeasure);
                      }
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Convert',style: TextStyle(fontSize: 30,color: Colors.amber),),

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text((errorMessage==null)?'':errorMessage


                  ,


                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),)




                ],
            ),
          ),
        ),
      ),);

  }
}
