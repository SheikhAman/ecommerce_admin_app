import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// akta general method jeta jekono dateTime er object ar pattern pass korle akta String return korbe
String getFormattedDateTime(DateTime dateTime,
        {String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dateTime);

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
