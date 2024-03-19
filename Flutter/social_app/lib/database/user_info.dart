/* User class which holds all User information */
class User_Info {
  String user_id;
  String username;
  String display_name;
  String email;
  String profile_picture_path;
  String biography;
  String private_profile;

  User_Info(
      {required this.user_id,
      required this.username,
      required this.display_name,
      required this.email,
      required this.profile_picture_path,
      required this.biography,
      required this.private_profile});
}
