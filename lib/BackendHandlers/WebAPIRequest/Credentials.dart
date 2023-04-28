class Credentials{
  String SessionKey;
  String UserID;
  Credentials(this.SessionKey,this.UserID){

  }
  Map toJson() => {
    'SessionKey': SessionKey,
    'UserID': UserID
  };
}