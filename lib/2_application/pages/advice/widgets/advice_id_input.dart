import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/advicer_cubit.dart';

class AdviceIdInput extends StatefulWidget {
  const AdviceIdInput({super.key});
  @override
  State<AdviceIdInput> createState() => _AdviceIdInputState();
}

class _AdviceIdInputState extends State<AdviceIdInput> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  // Clean up the controller when the widget is disposed.
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    int? id;
    return Column(
      children: [
        Form(
          key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                          icon: Icon(Icons.question_answer),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1.0,color:Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1.0,color:Colors.white),
                          ),
                          helperText: ''' Any positive number ''',
                          label: Text('Optionally enter an Advice id',
                              style: themeData.textTheme.labelLarge),
                        ),
                        initialValue: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            id = null;
                          } else if (isNumeric(value)) {
                            id = int.tryParse(value);
                          } else {
                            return 'Please enter an integer number';
                          }
                          return null;
                        }),
                  ),
                  CustomButton(
                      id: id,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AdvicerCubit>(context)
                              .adviceRequested(id);
                        }
                      }),
                ],
              ),

          ),
      ],
    );
  }
}

bool isNumeric(String s) {
  return int.tryParse(s) != null ? true : false;
}
