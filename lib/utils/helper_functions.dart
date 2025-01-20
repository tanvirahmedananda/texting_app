import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


const img = 'https://media.istockphoto.com/id/1313644269/vector/gold-and-silver-circle-star-logo-template.jpg?s=612x612&w=0&k=20&c=hDqCI9qTkNqNcKa6XS7aBim7xKz8cZbnm80Z_xiU2DI=';

void showMsg(BuildContext context, String msg, Color color) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
        ),
        content: Text(
          msg,
          style: TextStyle(color: color),
        )
    ));

String getFormattedDateTime(DateTime dateTime, String format) =>
    DateFormat(format).format(dateTime);
