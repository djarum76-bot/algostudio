class Url{
  static const baseURL = "https://api.imgflip.com/";

  static String meme(MemeEndpoint memeEndpoint){
    switch(memeEndpoint){
      case MemeEndpoint.list:
        return 'get_memes';
    }
  }
}

enum MemeEndpoint{
  list
}

typedef JSONData = Map<String,dynamic>;