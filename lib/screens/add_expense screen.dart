import 'package:ExpensePlanner/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddExpenseScreen extends StatefulWidget {
  Transactions tran;

  AddExpenseScreen([this.tran]);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  DateTime selectDate;
  File _storedImage;
  String imgURL = "";
  bool _isUpdate = false;
  final _form = GlobalKey<FormState>();
  var _editedForm = Transactions(
    id: null,
    title: "",
    description: "",
    amount: 0,
  );

  @override
  void initState() {
    if (widget.tran != null) {
      selectDate = DateTime.parse(widget.tran.date);
      imgURL = widget.tran.image;
    }
    super.initState();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          selectDate = pickedDate;
        });
      }
    });
  }

  bool _onSave() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return false;
    }
    _form.currentState.save();
    if (widget.tran == null) {
      Transactions.add(_editedForm, context, selectDate, _storedImage);
    } else if (_isUpdate) {
      Transactions.update(
          _editedForm, widget.tran.id, context, selectDate, _storedImage);
    } else {
      Transactions.update(_editedForm, widget.tran.id, context, selectDate);
    }
  }

  void _pickImage(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("OPEN WITH",
                  style: TextStyle(color: Color.fromRGBO(79, 99, 103, 1))),
              actions: [
                FlatButton.icon(
                    onPressed: () async {
                      final imgFile =
                          await _picker.getImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 150,maxHeight: 150);
                      if (imgFile == null) {
                        return;
                      }
                      Navigator.of(context).pop();
                      setState(() {
                        _storedImage = File(imgFile.path);
                        imgURL = "";
                        _isUpdate = true;
                      });
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Color.fromRGBO(122, 158, 159, 1),
                    ),
                    label: Text(
                      "Camera",
                      style: TextStyle(color: Color.fromRGBO(122, 158, 159, 1)),
                    )),
                FlatButton.icon(
                    onPressed: () async {
                      final imgFile =
                          await _picker.getImage(source: ImageSource.gallery,imageQuality: 50,maxHeight: 150,maxWidth: 150);
                      if (imgFile == null) {
                        return;
                      }
                      Navigator.of(context).pop();
                      setState(() {
                        _storedImage = File(imgFile.path);
                        imgURL = "";
                        _isUpdate = true;
                      });
                    },
                    icon: Icon(
                      Icons.picture_in_picture,
                      color: Color.fromRGBO(122, 158, 159, 1),
                    ),
                    label: Text(
                      "Gallery",
                      style: TextStyle(color: Color.fromRGBO(122, 158, 159, 1)),
                    )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(184, 216, 216, 1),
        toolbarHeight: Constants.getSize(context).height * 0.07,
        title: Text(
          "TITLE",
          style: TextStyle(color: Color.fromRGBO(79, 99, 103, 1), fontSize: 22),
        ),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _onSave),
        ],
      ),
      body:Form(
              key: _form,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: Constants.getSize(context).height * 0.03,
                    left: Constants.getSize(context).width * 0.04,
                    right: Constants.getSize(context).width * 0.04),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: Constants.getSize(context).height * 0.09,
                          backgroundImage: imgURL == ""
                              ? _storedImage == null
                                  ? NetworkImage(
                                      "https://ak.picdn.net/shutterstock/videos/1459387/thumb/1.jpg?ip=x480")
                                  : FileImage(_storedImage)
                              : NetworkImage(imgURL),
                        ),
                        Positioned(
                          bottom: Constants.getSize(context).height * 0.01,
                          right: Constants.getSize(context).width * 0.01,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 38,
                              color: Color.fromRGBO(79, 99, 103, 1),
                            ),
                            onPressed: () => _pickImage(context),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Constants.getSize(context).height * 0.02,
                    ),
                    Container(
                      width: Constants.getSize(context).width,
                      height: Constants.getSize(context).height * 0.06,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          bottom: Constants.getSize(context).height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(238, 245, 219, 1),
                      ),
                      child: TextFormField(
                        initialValue:
                            widget.tran != null ? widget.tran.title : "",
                        decoration: InputDecoration(
                          hintText: "TITLE",
                          hintStyle: TextStyle(fontSize: 18),
                          border: InputBorder.none,
                        ),
                        cursorColor: Color.fromRGBO(122, 158, 159, 1),
                        maxLines: 1,
                        style: TextStyle(fontSize: 18),
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter a required field";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedForm = Transactions(
                            title: value,
                            description: _editedForm.description,
                            id: _editedForm.id,
                            amount: _editedForm.amount,
                          );
                        },
                      ),
                    ),
                    Container(
                      width: Constants.getSize(context).width,
                      height: Constants.getSize(context).height * 0.06,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          bottom: Constants.getSize(context).height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(238, 245, 219, 1),
                      ),
                      child: TextFormField(
                        initialValue:
                            widget.tran != null ? widget.tran.description : "",
                        decoration: InputDecoration(
                          hintText: "DESCRIPTION",
                          hintStyle: TextStyle(fontSize: 18),
                          border: InputBorder.none,
                        ),
                        cursorColor: Color.fromRGBO(122, 158, 159, 1),
                        maxLines: 1,
                        style: TextStyle(fontSize: 18),
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter a required field";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedForm = Transactions(
                            title: _editedForm.title,
                            description: value,
                            id: _editedForm.id,
                            amount: _editedForm.amount,
                          );
                        },
                      ),
                    ),
                    Container(
                      width: Constants.getSize(context).width,
                      height: Constants.getSize(context).height * 0.06,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          bottom: Constants.getSize(context).height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(238, 245, 219, 1),
                      ),
                      child: TextFormField(
                        initialValue: widget.tran != null
                            ? widget.tran.amount.toString()
                            : "",
                        decoration: InputDecoration(
                          hintText: "AMOUNT",
                          hintStyle: TextStyle(fontSize: 18),
                          border: InputBorder.none,
                        ),
                        cursorColor: Color.fromRGBO(122, 158, 159, 1),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 18),
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter a required field";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedForm = Transactions(
                            title: _editedForm.title,
                            description: _editedForm.description,
                            id: _editedForm.id,
                            amount: double.parse(value),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(selectDate == null
                              ? '  No date chosen!'
                              : '  Picked Date: ${DateFormat.yMMMd().format(selectDate)}'),
                        ),
                        FlatButton(
                          textColor: Color.fromRGBO(122, 158, 159, 1),
                          child: Text(
                            widget.tran == null
                                ? 'Choose date!'
                                : 'Change Date!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: presentDatePicker,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
