import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{

  NetworkHelper(this.url);
  String url;
  Future<dynamic> getData() async {
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        String data = response.body;
        double price = jsonDecode(data)['rate'];
        return price ;
      }
      else{
        print(response.statusCode);
      }
    }
}
