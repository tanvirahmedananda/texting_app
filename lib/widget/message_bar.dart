import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:texting_app/utils/constants.dart';
import 'package:texting_app/widget/poppins_text.dart';

class MessageBar extends StatelessWidget {
  final username;
  final time;
  final text;
  const MessageBar({
    super.key,
    required this.username,
    required this.time,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mQHeight(52, context),
      width: mQWidth(358, context),
      child: Row(
        children: [
          Container(
            height: mQHeight(52, context),
            width: mQHeight(52, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: mQWidth(12, context),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                        text: username,
                        fontSize: 15,
                        color: Colors.black,
                        weight: FontWeight.w500),
                    PoppinsText(
                        text: 'time',
                        fontSize: 11,
                        color: grey,
                        weight: FontWeight.w500),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: mQHeight(30.4, context),
                      width: mQWidth(270, context),
                      child: Text(
                        text,
                        maxLines: 2 ,overflow: TextOverflow.ellipsis ,style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}