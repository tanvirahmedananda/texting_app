import 'package:flutter/material.dart';
import 'package:texting_app/utils/constants.dart';
import 'package:texting_app/widget/poppins_text.dart';


class ReciverTextBox extends StatelessWidget {
  final String? text;
  final DateTime? time;
  final String? image;
  const ReciverTextBox({
    super.key,
    this.text,
    this.time,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: mQHeight(16, context),),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: mQHeight(34, context),
              width: mQHeight(34, context),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(mQHeight(17, context))
              ),
            ),
            SizedBox(width: mQWidth(6, context),),
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
                        PoppinsText(text: "${time?.hour}:${time?.minute}", fontSize: 10, color: green, weight: FontWeight.w300),
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