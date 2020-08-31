import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocumentCallbackButton extends StatelessWidget {
  final String _label;
  final Function _callback;
  final DocumentSnapshot _document;
  final BuildContext _context;

  DocumentCallbackButton(
      this._label, this._callback, this._document, this._context);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          _label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          _callback(_document, _context);
          Navigator.pop(context);
        },
      ),
    );
  }
}
