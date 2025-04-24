import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  late LocationData _locData;


  Future<void> initialize() async{
    bool _serviceEnabled;
    PermissionStatus _permission;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();

      if(!_serviceEnabled){
        return;
      }
    }

    _permission = await location.hasPermission();
    if(_permission == PermissionStatus.denied){
      _permission = await location.requestPermission();

      if(_permission != PermissionStatus.granted){
        return;
      }
    }
  }

  Future<double?> getLatitude() async{
    _locData = await location.getLocation();
    if(_locData.latitude == null || _locData.latitude == 0.0){
      return null;
    }
    return _locData.latitude;
  }

  Future<double?> getLongitude() async{
    _locData = await location.getLocation();
    if(_locData.longitude == null || _locData.longitude == 0.0){
      return null;
    }
    return _locData.longitude;
  }
}