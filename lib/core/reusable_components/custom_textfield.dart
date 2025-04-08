import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget{
  String hinttext;
  String ? prifex;
  TextInputType keyboard;
  bool isobsecured;
  int maxlines;
  String?Function(String?)validator;

  TextEditingController controller;
  CustomField({required this.hinttext, this.prifex,
    required this.controller,required this.keyboard,this.isobsecured=false,
    required this.validator,this.maxlines=1});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool passtoggle=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        validator:widget.validator,


        controller:widget.controller,
        keyboardType: widget.keyboard,
        obscureText:widget.isobsecured ?passtoggle:false,
        decoration:InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              )
          ),
          prefixIconConstraints: BoxConstraints(maxWidth:60,maxHeight:24 ),
          prefixIcon:widget.prifex==null?null
              :Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SvgPicture.asset(widget.prifex!,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onTertiaryContainer, BlendMode.srcIn),
            ),
          ),
          hintStyle:Theme.of(context).textTheme.bodySmall,
          hintText:widget.hinttext,
          suffixIcon:widget.isobsecured? IconButton(onPressed: (){
            setState(() {
              passtoggle=!passtoggle;

          });

          },icon:Icon(passtoggle?Icons.visibility_off_rounded:
          Icons.visibility_rounded,
            size: 24,
            color: Theme.of(context).colorScheme.onTertiaryContainer,)):null) ,



      ),
    );
  }
}