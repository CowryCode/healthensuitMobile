import 'package:flutter/material.dart';

class PatientName extends StatelessWidget{
  final String? patientNameText;
  final Function? buttonEvent;

  PatientName({ required this.patientNameText, this.buttonEvent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children : <Widget>[
          Text(
            'NAME',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.0),

          SingleChildScrollView(
          scrollDirection: Axis.horizontal,
      
          child: Row(
            children: <Widget> [
              Text(
                patientNameText.toString(),
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
                letterSpacing: 1.0,
              ),
              ),
              SizedBox(width: 1.0,),
              IconButton(
                onPressed: buttonEvent as void Function()?,
                icon: Icon(Icons.edit),
              ),
            ] 
          ),
        ),
      ],
    );
  }
}