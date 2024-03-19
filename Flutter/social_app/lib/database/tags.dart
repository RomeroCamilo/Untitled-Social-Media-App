/* User class which holds all tag information */

class Tags {
  String user_id;
  String artist_tag_1;
  String genre_tag_1;
  String song_tag_1;
  String artist_tag_2;
  String genre_tag_2;
  String song_tag_2;
  String artist_tag_3;
  String genre_tag_3;
  String song_tag_3;


  Tags(
      {required this.user_id,
      required this.artist_tag_1,
      required this.genre_tag_1,
      required this.song_tag_1,
      required this.artist_tag_2,
      required this.genre_tag_2,
      required this.song_tag_2,
      required this.artist_tag_3,
      required this.genre_tag_3,
      required this.song_tag_3
      });
}