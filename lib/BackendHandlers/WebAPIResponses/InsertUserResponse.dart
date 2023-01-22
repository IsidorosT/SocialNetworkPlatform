class InsertUserResponse{
  bool Success;
  String ErrorMessage;

  InsertUserResponse(this.Success,this.ErrorMessage){

  }
  InsertUserResponse.fromJson(Map<String, dynamic> json) {
    Success = json['success'];
    ErrorMessage = json['errorMessage'];
  }
}