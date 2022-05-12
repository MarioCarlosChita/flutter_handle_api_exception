import 'package:flutter/cupertino.dart';
import 'package:handle_exception_api/models/post.dart';
import 'package:handle_exception_api/service/api/base_client.dart';
import 'package:handle_exception_api/service/api/base_service.dart';


class PostService{
     final BaseClient  _baseClient = BaseClient();
     final BuildContext context ;
     PostService({required this.context});

     Future<List<Post>>   fetchPosts() async{
          final BaseService  _baseService =  BaseService(context);
          final _response  =await _baseClient
              .get("https://jsonplaceholder.typicode.com", "/posts")
              .catchError(_baseService.handleError);

          return _response !=  null ?
               List.from(_response).map((e) => Post
              .fromJson(e))
              .toList(): [];
     }

}