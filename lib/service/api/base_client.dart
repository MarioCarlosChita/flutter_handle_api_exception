import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../../exceptions/app_exceptions.dart';
import 'package:http/http.dart' as http;

class BaseClient{
  static const int   TIME_OUT_DURATION =20 ;

  Future<dynamic> get(String baseUrl ,  String api) async{
     var uri  =  Uri.parse(baseUrl +api);
     try{
       var  response  = await http.get(uri).timeout( const  Duration(seconds: TIME_OUT_DURATION));
       return   _processResponse(response);
     } on SocketException{
       throw  NoInternerConnection('No Internet connection', uri.toString());
     } on TimeoutException{
         throw ApiNotRespondingException('API not responded', uri.toString());
     } on FetchDataException{
       throw  FetchDataException('Servidor Desconhecido', uri.toString());
     }

  }



  dynamic _processResponse(http.Response response){
      switch(response.statusCode){
        case  200:
            var responseJson = json.decode(response.body);
            return responseJson;
        break;

        case 400:
            throw BadRequestException(json.decode(response.body),response.request!.url.toString());
        break;

        case 401:
        case 403:
           throw UniAuthorizedException(json.decode(response.body),response.request!.url.toString());
        break;

        case 500 :
        default:
            throw  FetchDataException('Error occured with code:${response.statusCode}',response.request!.url.toString());
      }
  }
}