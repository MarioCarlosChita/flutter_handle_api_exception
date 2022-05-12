import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handle_exception_api/exceptions/app_exceptions.dart';

class BaseService{
     BuildContext context ;
     BaseService(this.context);
     void  handleError(error){
        if(error is BadRequestException){
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro de requesição',style: TextStyle(
             color:Colors.white,
             fontSize: 15
           ),)));
        }

        if(error is  FetchDataException){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message,style: const TextStyle(
              color:Colors.white,
              fontSize: 15
          ),)));
        }

        if(error is  ApiNotRespondingException){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('O Servidor não está respondendo',style: TextStyle(
              color:Colors.white,
              fontSize: 15
          ),)));
        }

        if(error is NoInternerConnection ){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message,style: TextStyle(
              color:Colors.white,
              fontSize: 15
          ),)));
        }
    }
}