
class ApiException implements Exception{
   String message;
   String prefix;
   String url ;
   ApiException(this.message,  this.prefix , this.url,);
}


class BadRequestException extends ApiException{
  BadRequestException(String message, String url) :
        super(message, "Bad Request", url);
}

class FetchDataException extends ApiException{
   FetchDataException(String message, String url) :
         super(message, "Unable  to  process", url);
}

class ApiNotRespondingException extends ApiException{
    ApiNotRespondingException(String message,String url) :
           super(message, 'Api is not responding', url);

}

class UniAuthorizedException extends ApiException{
  UniAuthorizedException(String message, String url) :
         super(message, "uniauthorizedException  request", url);

}

class NoInternerConnection extends ApiException{
  NoInternerConnection(String message, String url) :
        super(message, "No Internet Connection", url);
 }
