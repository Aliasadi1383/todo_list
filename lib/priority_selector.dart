import 'package:flutter/material.dart';

class PrioritySelector extends StatefulWidget {
  final Function(int) onPriorityChanged; 
  const PrioritySelector({super.key,required this.onPriorityChanged});

  @override
  State<PrioritySelector> createState() => _PrioritySelector();
}

class _PrioritySelector extends State<PrioritySelector> {
  int selector = 3;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildItem(id: 1, lable: 'High', color: Colors.deepPurple),
        buildItem(id: 2, lable: 'Normal', color: Colors.orange),
        buildItem(id: 3, lable: 'Low', color: Colors.blue),
      ],
    );
  }

  Widget buildItem({
    required int id,
    required String lable,
    required Color color,
  }) {

    bool isSelected=(selector==id);

    return InkWell(
      onTap: () {
        setState(() {
          selector=id;
        });

        widget.onPriorityChanged(selector);
      },
      child: Container(
         width: 120,
         height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color:Color.fromARGB(255, 193, 193, 193), width: 2),
          color: Colors.transparent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          
          Text(lable,style:const TextStyle(fontSize: 15),),
          const SizedBox(width: 17),
         Container(
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle
           
          ),
          child: isSelected?
          Icon( Icons.check, size: 15,color: Theme.of(context).colorScheme.onPrimary,)
          :null,
         ),
        const SizedBox(width: 5,)
        ],),
      ),
    );
  }
}
