class NetworkCallEvents{}

class MakeRequest extends NetworkCallEvents{
  MakeRequest(this.url);
  final String url;
}
