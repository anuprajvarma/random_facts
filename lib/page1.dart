import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String fact = 'factech!!!!';
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              status
                  ? CircularProgressIndicator()
                  : Text(
                      fact,
                    ),
              SizedBox(
                height: 100.0,
              ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    status = true;
                  });
                  var response = await get(Uri.parse(
                      'https://uselessfacts.jsph.pl/random.json?language=en'));

                  setState(() {
                    status = false;
                  });
                  if (response.statusCode == 200) {
                    var mapofDate = jsonDecode(response.body);
                    print(mapofDate['text']);
                    setState(() {
                      fact = mapofDate['text'];
                    });
                  } else {
                    print('faild');
                  }
                },
                child: Text(
                  'next fact',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
