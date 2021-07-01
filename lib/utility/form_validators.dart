class Validators{
 static String validateEmptyField(String value) {
    if (value.length == 0) {
      return 'this field is required';
    } else {
      return null;
    }
  }

  static String validatePhone(String value){
   if(value.length==0){
     return 'this field is required';
   }
   else if(value.length!=10){
     return 'please enter valid phone no';
   }
   else{
     return null;
   }
  }
}