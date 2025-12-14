import 'package:get/get_utils/src/get_utils/get_utils.dart';

validInput(String val, int minLength, int maxLength, String type) {
  
  if (type == 'number') {
    if (!GetUtils.isNum(val)) {
      return 'invalid value please enter correct number';
    }
  }

  if (type == 'text') {
    if (GetUtils.isNull(val)) {
      return 'You can\'t leave this field empty';
    }
  }
 
  if (val.length < minLength) {
    return 'minimum value is $minLength characters';
  }
  if(val.length > maxLength){
    return 'maximum value is $maxLength characters';
  }
}
