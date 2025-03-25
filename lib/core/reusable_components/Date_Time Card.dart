import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:flutter/material.dart';

class DateTimeCard extends StatelessWidget{
  final String date;
  const DateTimeCard({required this.date, super.key});
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.primary_light)),
        padding: EdgeInsets.all(8),
        child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration:  BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Icon(Icons.calendar_month,size: 32,color: Theme.of(context).colorScheme.secondary),
            
        
          ),
          const SizedBox(width:8,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: Theme.of(context).textTheme.titleSmall!
                    .copyWith(color: ColorsManager.primary_light),)
            ],
          ))
          
        ],
            ),
      ) ;
  }

}