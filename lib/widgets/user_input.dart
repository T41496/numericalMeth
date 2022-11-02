import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  
  final TextEditingController expressionController, errorController;
  final GlobalKey<FormState> formKey;
  final Function validator, expressionValidator, errorValidator;

  UserInput(
      {@required this.expressionController,
      @required this.errorController,
      @required this.validator,
      @required this.formKey,
      @required this.expressionValidator,
      @required this.errorValidator});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: expressionController,
                autofocus: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Expression*",
                    hintText: "Note:for log(x) type:ln(x)/2.3026"),
                validator: expressionValidator,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: errorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Error*",
                    hintText: "0.0005"),
                validator: errorValidator,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        validator(context);
                      },
                      child: Text("Calculate"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
