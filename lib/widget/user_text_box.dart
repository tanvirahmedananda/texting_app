import 'package:flutter/material.dart';
import 'package:texting_app/utils/constants.dart';
import 'package:texting_app/widget/poppins_text.dart';


class UserTextBox extends StatelessWidget {
  final String? text;
  final String? time;
  const UserTextBox({
    super.key,
    this.text,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: mQHeight(16, context),),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FittedBox(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(mQHeight(12, context))
                ),
                width: mQWidth(287, context),
                child: Column(
                  children: [
                    Text(text!),
                    SizedBox(height: mQHeight(5, context),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PoppinsText(text: time!, fontSize: 10, color: green, weight: FontWeight.w300),
                      ],
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}