class Credentials{
  String SessionKey;
  String UserID;
  Credentials(sessionKey,userID){
    SessionKey = sessionKey;
    UserID = userID;
  }
  Map toJson() => {
    'SessionKey': SessionKey,
    'UserID': UserID
  };
}