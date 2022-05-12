import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handle_exception_api/models/post.dart';
import 'package:handle_exception_api/service/post_service/post_service.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   late PostService _postService ;
   final StreamController<List<Post>> _controller =  new StreamController.broadcast();
  @override
  void initState() {
    this._onLoadingData();
    super.initState();
  }


  void _onLoadingData() async{
    _postService = new PostService(context: context);
    List<Post>  _listPosts =  await _postService.fetchPosts();
    if(!_controller.isClosed){
       _controller.sink.add(_listPosts);
    }
  }

  void dispose(){
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: StreamBuilder<List<Post>>(
          stream: _controller.stream,
          builder: (_ ,data) {
            switch(data.connectionState){
              case  ConnectionState.waiting:
                 return const Center(
                    child: CircularProgressIndicator(),
                 );
              case ConnectionState.active:
              case ConnectionState.done:
                 if(data.hasError){
                     return const  Center(
                        child: Text('Error tentanovamamente' , style: TextStyle(
                           fontSize: 11,

                        ),),
                     );
                 }else{
                     List<Post>  lista =  data.data ??  [];
                     return ListPostsWidgets(lista: lista);
                 }
              default:
                  return const SizedBox.shrink();

            }
          },
       ),
    );
  }
}

class ListPostsWidgets extends StatelessWidget{
     List<Post> lista;
     ListPostsWidgets({Key? key , required this.lista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.lista.length,
        itemBuilder: (_ ,index){
          return Container(
              height:40,
             child: ListTile(
                 title: Text(this.lista[index].title),
                 subtitle: Text(this.lista[index].body),
             ),
          );
     });
  }

}
