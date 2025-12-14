import 'package:mohammed_admin/core/class/status_request.dart';

handlingData(response){
  if (response is StatusRequest){
   return response ; 
  }else {
   return StatusRequest.success ; 
  }
}