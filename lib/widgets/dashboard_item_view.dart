import 'package:ecom_day_42/models/dashboard_item.dart';
import 'package:flutter/material.dart';
class DashboardItemView extends StatelessWidget {
  final DashboardItem item;
  final Function(String) onPressed;
  const DashboardItemView({required this.item,required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed(item.title);
      },
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(item.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),),

          ],
        ),
      ),
    );
  }
}
