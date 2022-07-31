// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reel_ro/app/modules/homepage/widgets/comment_tile.dart';
import 'package:reel_ro/app/modules/single_feed/single_feed_controller.dart';
import 'package:reel_ro/repositories/comment_repository.dart';
import 'package:reel_ro/repositories/reel_repository.dart';
import 'package:reel_ro/utils/empty_widget.dart';
import 'package:reel_ro/widgets/loading.dart';
import '../../../models/photo_model.dart';
import '../../../models/reel_model.dart';
import '../../../utils/base.dart';
import '../../../utils/circle_animation.dart';
import '../../../utils/video_player_iten.dart';

class SingleFeedScreen extends StatelessWidget {
  SingleFeedScreen(this.reel, this.photo, {Key? key}) : super(key: key);

  ReelModel? reel;
  PhotoModel? photo;

  final _controller = Get.put(SingleFeedController());
  final _reelRepo = Get.put(ReelRepository());
  final _commentRepo = Get.put(CommentRepository());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final data = reel ?? photo;
    return GetBuilder<SingleFeedController>(
        builder: (_) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Get.back();
                    }),
                title: const Center(child: Text("Your Rolls")),
              ),
              body: _controller.loading
                  ? Loading()
                  : PageView.builder(
                      itemCount: 1,
                      controller:
                          PageController(initialPage: 0, viewportFraction: 1),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            VideoPlayerItem(
                              videoUrl:
                                  "https://reelro-vod-destinationbucket.s3.ap-south-1.amazonaws.com/reel/1/20220723/98989/reel_1_20220723_98989_file1.mp4",
                              doubleTap: () {
                                // _controller.likeToggle(index);
                              },
                              showLike: _controller.showLike,
                            ),
                            //  VideoPlayerItem(
                            //         videoUrl: reel!.filename,
                            //         doubleTap: () {
                            //           _controller.likeToggle(reel!);
                            //         },
                            //         showLike: _controller.showLike,
                            //       ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                reel!.video_title,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                reel!.description,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        margin: EdgeInsets.only(
                                            top: size.height / 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  // _controller.likeVideo(data.id),
                                                  child: const Icon(
                                                    Icons.card_giftcard,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                // const SizedBox(height: 7),
                                                Text(
                                                  '0',
                                                  style: style.headlineSmall!
                                                      .copyWith(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  // _controller.likeVideo(data.id),
                                                  child: Icon(
                                                    Icons.favorite,
                                                    size: 30,
                                                    color: Colors.red,
                                                  ),
                                                ),

                                                // const SizedBox(height: 7),
                                                FutureBuilder<int>(
                                                    future: _reelRepo
                                                        .getLikeCountByReelId(
                                                            _controller
                                                                .profileId!,
                                                            _controller.token!),
                                                    builder: (context, snap) {
                                                      return Text(
                                                        snap.hasData
                                                            ? snap.data!
                                                                .toString()
                                                            : '0',
                                                        // data.likeCount.toString(),
                                                        style: style
                                                            .headlineSmall!
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.bottomSheet(
                                                      CommentSheet(
                                                        reelId: reel!.id,
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.comment,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                FutureBuilder<int>(
                                                    future: _commentRepo
                                                        .getCommentCountByReelId(
                                                            _controller
                                                                .profileId!,
                                                            _controller.token!),
                                                    builder:
                                                        (context, snapshot) {
                                                      print(
                                                          "ReelId: ${reel!.id} CommentCount: ${snapshot.data}");
                                                      return Text(
                                                        snapshot.hasData
                                                            ? snapshot.data!
                                                                .toString()
                                                            : "0",
                                                        style: style
                                                            .headlineSmall!
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    })
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.reply,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                // const SizedBox(height: 7),
                                                // Text(
                                                //   '0',
                                                //   style: const TextStyle(
                                                //     fontSize: 20,
                                                //     color: Colors.white,
                                                //   ),
                                                // )
                                              ],
                                            ),
                                            CircleAnimation(
                                              child: buildMusicAlbum(
                                                  "${Base.profileBucketUrl}/${reel!.user.user_profile!.profile_img}"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
            ));
  }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: const Image(
                image: AssetImage(
                  "assets/Background.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }
}

class CommentSheet extends StatelessWidget {
  final int reelId;
  CommentSheet({Key? key, required this.reelId}) : super(key: key);

  buildProfile(String profilePhoto) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: const NetworkImage(
        "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80",
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CommentController(reelId: reelId));
    // _controller.customeInit();
    return GetBuilder<CommentController>(
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _controller.loading
            ? [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Loading(),
                )
              ]
            : [
                ListTile(
                  leading: Text('${_controller.commentList.length} Comments',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Divider(),
                // ListTile(
                //   leading: buildProfile(""),
                //   title: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           children: [
                //             Text(
                //               '@yashvala9',
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Text(
                //               '1 day ago',
                //             ),
                //           ],
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               'Hey! check this out.',
                //             ),
                //             Row(
                //               children: [
                //                 IconButton(
                //                     onPressed: () {},
                //                     icon: Icon(
                //                       Icons.favorite,
                //                       color: Colors.red,
                //                     )),
                //                 Text('2'),
                //               ],
                //             )
                //           ],
                //         ),
                //         InkWell(
                //             onTap: () {},
                //             child: Text(
                //               '2 Responses',
                //               style: TextStyle(color: Colors.blue),
                //             )),
                //       ],
                //     ),
                //   ),
                // ),
                if (_controller.commentList.isEmpty)
                  EmptyWidget("No comments available!")
                else
                  ..._controller.commentList
                      .map(
                        (e) => ListTile(
                          leading: buildProfile(""),
                          title: CommentWidget(
                            commentModel: e,
                            likeToggle: () {},
                            profileModel: e.user,
                          ),
                        ),
                      )
                      .toList(),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: buildProfile(""),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: ' Add a comment',
                          ),
                          onSaved: (v) {
                            _controller.comment = v!;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _controller.addComment();
                          }
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ],
                ),
              ],
      ),
    );
  }
}
