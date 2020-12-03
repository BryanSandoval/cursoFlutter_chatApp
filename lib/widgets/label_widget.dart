import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String rutaDestino;
  final String textoCuenta1;
  final String textoCuenta2;
  const Labels(
      {Key key,
      @required this.rutaDestino,
      @required this.textoCuenta1,
      @required this.textoCuenta2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.textoCuenta1,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(this.textoCuenta2,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, rutaDestino);
            },
          )
        ],
      ),
    );
  }
}
