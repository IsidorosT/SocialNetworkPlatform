class MemoryRequest{
  bool IncludeUsers;
  bool IncludePosts;
  bool IncludeLikes;
  bool IncludeFriends;
  String SessionKey;
  MemoryRequest(bool includeUsers, bool includePosts, bool includeLikes, bool includeFriends, String sessionKey){
    IncludeUsers = includeUsers;
    IncludePosts = includePosts;
    IncludeLikes = includeLikes;
    IncludeFriends = includeFriends;
    SessionKey = sessionKey;
  }
  Map toJson() => {
    'IncludeUsers': IncludeUsers,
    'IncludePosts': IncludePosts,
    'IncludeLikes': IncludeLikes,
    'IncludeFriends': IncludeFriends,
    'SessionKey': SessionKey
  };
}