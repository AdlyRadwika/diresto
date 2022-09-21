import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/provider/restaurant_provider.dart';
import 'package:diresto/pages/review/widgets/text_field_widget.dart';

class InputReviewWidget extends StatefulWidget {
  final RestaurantDetailList resto;
  
  const InputReviewWidget({Key? key, required this.resto}) : super(key: key);

  @override
  State<InputReviewWidget> createState() => _InputReviewWidgetState();
}

class _InputReviewWidgetState extends State<InputReviewWidget> {
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _inputKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Column(
              children: [
                Form(
                  key: _inputKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
                          textEditingController: _nameController,
                          emptyWarning: "Input the name",
                          hintText: "John",
                          labelText: "Name"
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                          textEditingController: _reviewController,
                          emptyWarning: "Input the review",
                          hintText: "This restaurant is fire!",
                          labelText: "Review"
                      ),
                      const SizedBox(height: 15,),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if(_inputKey.currentState!.validate()) {
                              _submitReviewData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Review has been added!'),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Text('Add Review'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _submitReviewData() {
    final idValue = widget.resto.id;
    final nameValue = _nameController.text;
    final reviewValue = _reviewController.text;

    Provider.of<RestaurantDetailProvider>(context, listen: false)
        .sendCustomerReview(idValue, nameValue, reviewValue);



    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _reviewController.dispose();
  }
}
