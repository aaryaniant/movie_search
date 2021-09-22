import 'package:flutter/material.dart';

Widget loader(context){
  return  Container(
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: Center(
                            child: Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Color(0xffe41212),
                                  strokeWidth: 2,
                                )),
                          ),
                        );
}