import 'package:flutter/material.dart';


showTambolaGrid(){
  return Padding(
    padding: const EdgeInsets.only(bottom: 16,top: 32,left: 16,right: 16),
    child: GridView.builder(
      shrinkWrap: true,
        itemCount: 27,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9),
        itemBuilder: (ctx, index) {
          return index % 2 == 1 ? Container(
            color: Colors.green,
            child: Center(child: Text(index.toString())),
          ) :  Container(
            child: Center(child: Text(index.toString())),
          );
        }),
  );
}