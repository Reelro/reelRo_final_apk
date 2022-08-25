class Base {
  static const _url = 'http://13.234.159.127';

  static const register = "$_url/users/";
  static const login = '$_url/login';
  static const sendVeifyEmailLink = '$_url/users/send_activation_email';
  // static const createProfile = '$_url/profiles';
  static const verifyOtp = '$_url/auth/register/verifyOTP';
  static const getProfileId = '$_url/users/me';
  static const getProfileByToken = '$_url/users/getcurrent_user';
  // static const getProfilebyId = '$_url/user-profiles';
  static const getReelsbyId = '$_url/getReelsByUserId';
  // static const createProfile = '$_url/user-profiles';
  static const searchUser = '$_url/search';

  //Forget password
  static const generateForgetPasswordToken =
      '$_url/forgot_password/generate_token';
  static const validateForgetPasswordtoken =
      '$_url/forgot_password/validate_token';
  static const setForgetPassword = '$_url/forgot_password';

  //logout
  static const logout = '$_url/logout';

  //FCM
  static const fcmRegister = '$_url/notify/register';

  //Profile
  static const currentUser = '$_url/users/getcurrent_user';
  static const getUserProfile = '$_url/users/profile';
  static const createProfile = '$_url/users/profile';
  static const updateProfile = '$_url/users/profile/update';
  static const getProfileById = '$_url/users/profile';

  //notification
  static const notificaitonList = '$_url/notify/list';
  static const pokeSingleUser = '$_url/notify/poke/';
  static const pokeAllInactiveUser = '$_url/notify/pokeInactive';

  //Get Entity
  static const getEntity = '$_url/reels/get';

  //Referral
  static const getsetReferralStatus = '$_url/users';
  static const addReferral = '$_url/users/referrer';

  //Reels
  static const getReelsByUserId = '$_url/reels/user';
  static const getFeedsByUserId = '$_url/getFeed';
  static const getPhotosByUserId = '$_url/getPhotosByUserId';
  static const updateStatus = '$_url/reels/update/status/';
  static const reels = '$_url/reels/';
  static const reelsWithAds = '$_url/reels/with_ads';
  static const reelsByHashTag = '$_url/hashtags/reels/';
  static const getSingleReel = '$_url/reels/single';

  //Report
  static const report = '$_url/reels/report';

  //Ads

  static const adsHistoryByProfileId = '$_url/ads/history';
  static const ads = '$_url/ads/display';
  static const adsHistory = '$_url/ads/history/';
  static const setRandomWinner = '$_url/winners';
  static const reelHistory = '$_url/reels/history/';
  static const addReel = '$_url/reels';
  static const deleteReel = '$_url/reels/delete';
  static const isActive = '$_url/ads/status/';

  //Following Followers
  static const getFollowing = '$_url/users';
  static const isFollowing = '$_url/users/follow';
  static const toggleFollow = '$_url/users/follow';

  //Upload Video and photo
  static const uploadVideo = '$_url/upload';

  //Profile Bucket base url
  static const profileBucketUrl =
      'https://reelro-image-bucket.s3.ap-south-1.amazonaws.com/inputs';

  //Like
  static const toggleLike = '$_url/reels/likes';
  static const getLikeFlag = '$_url/reels/isLiked';
  static const getLikeCount = '$_url/count/likes/reels';

  //Comment

  static const getCommentByReelId = '$_url/reels/comments/';
  static const addCommentToReelId = '$_url/reels/comments';
  static const toggleCommentLike = '$_url/reels/likes/comments';

  static const deleteComment = '$_url/reels/comments';
  static const nestedComment = '$_url/reels/comments';
  static const getCommentCount = '$_url/count/comments';
  static const getCommentLikeCount = '$_url/count/likes/comments/';

  //Giveaway
  static const giveaway = '$_url/contests/';
  static const CreateGiveaway = '$_url/createContest';
  static const getAdsEntryCountByUserId = '$_url/ads-histories/count';
  static const getReferralsEntryCountByUserId = '$_url/referrals/count';
  static const getTotalEntryCountByUserId = '$_url/totalEntries';
  static const getBuddyPairByUserId = '$_url/referrals/get_buddy';
  static const imageUpload = '$_url/upload';
  static const winners = '$_url/winners';
  static const referrals = '$_url/referrals';
}
