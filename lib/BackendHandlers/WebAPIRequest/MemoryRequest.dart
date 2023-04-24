class MemoryRequest{
  bool IncludeUsers;
  bool IncludePosts;
  bool IncludeLikes;
  bool IncludeFriends;
  bool IncludeMessages;
  bool IncludeConversations;
  String SessionKey;
  String UserID;

  MemoryRequest(
      bool includeUsers,
      bool includePosts,
      bool includeLikes,
      bool includeFriends,
      bool includeMessages,
      bool includeConversations,
      String sessionKey,
      String userid){
    IncludeUsers = includeUsers;
    IncludePosts = includePosts;
    IncludeLikes = includeLikes;
    IncludeFriends = includeFriends;
    IncludeMessages = includeMessages;
    IncludeConversations = includeConversations;
    SessionKey = sessionKey;
    UserID = userid;
  }
  Map toJson() => {
    'IncludeUsers': IncludeUsers,
    'IncludePosts': IncludePosts,
    'IncludeLikes': IncludeLikes,
    'IncludeFriends': IncludeFriends,
    'IncludeMessages': IncludeMessages,
    'IncludeConversations': IncludeConversations,
    'SessionKey': SessionKey,
    'UserID': UserID
  };
}