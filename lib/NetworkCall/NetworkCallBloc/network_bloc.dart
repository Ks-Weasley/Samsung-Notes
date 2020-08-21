import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../json_to_dart.dart';
import 'network_events.dart';
import 'network_state.dart';


class NetworkCallBloc extends Bloc<NetworkCallEvents, NetworkCallState>{
  @override
  NetworkCallState get initialState => InitialState();

  @override
  Stream<NetworkCallState> mapEventToState(NetworkCallEvents event) async*{
    if(event is MakeRequest){
      yield Loading();
      final http.Response response = await http.get(event.url);
      if(response.statusCode == 200){
        final List<Dictionary> convertedObject = dictionaryFromJson(response.body);
        yield SuccessfulCall(dictionary: convertedObject);
      }else{
        yield FailedRequest();
      }
    }
  }

}