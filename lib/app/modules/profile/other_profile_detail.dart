import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reel_ro/app/modules/auth/auth_controller.dart';
import 'package:reel_ro/app/modules/search/search_controller.dart';
import 'package:reel_ro/models/profile_model.dart';
import 'package:reel_ro/services/auth_service.dart';
import '../../../models/reel_model.dart';
import '../../../repositories/profile_repository.dart';
import '../../../utils/assets.dart';
import '../../../widgets/my_elevated_button.dart';
import '../single_feed/single_feed_screen.dart';

class OtherProfileDetail extends StatefulWidget {
  final ProfileModel profileModel;
  const OtherProfileDetail({Key? key, required this.profileModel})
      : super(key: key);

  @override
  State<OtherProfileDetail> createState() => _OtherProfileDetailState();
}

class _OtherProfileDetailState extends State<OtherProfileDetail> {
  final _profileRepo = Get.put(ProfileRepository());

  final _authService = Get.put(AuthService());

  void toggleFollowing(int profileId, String token) async {
    try {
      _profileRepo.toggleFollow(profileId, token);
      setState(() {});
    } catch (e) {
      log("toggleFollowingError: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return DefaultTabController(
      length: widget.profileModel.status == 'VERIFIED' ? 3 : 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  GetBuilder<AuthController>(builder: (_) {
                    return Stack(
                      children: [
                        Container(
                          height: Get.height * 0.2,
                          color: colorScheme.primaryContainer,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 100, bottom: 10),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40))),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                                child: Material(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.08,
                                      ),
                                      Text(
                                        widget.profileModel.user_profile!
                                            .fullname!,
                                        style: style.headline5,
                                      ),
                                      SizedBox(
                                        height: 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: ListTile(
                                              title: Text(
                                                  widget.profileModel.noOfPosts
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: style.headline6),
                                              subtitle: Text(
                                                "Posts",
                                                textAlign: TextAlign.center,
                                                style: style.titleMedium,
                                              ),
                                            )),
                                            Expanded(
                                                child: ListTile(
                                              title: Text(
                                                  widget.profileModel
                                                      .followerCount
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: style.headline6),
                                              subtitle: Text("Followers",
                                                  textAlign: TextAlign.center,
                                                  style: style.titleMedium),
                                            )),
                                            Expanded(
                                                child: ListTile(
                                              title: Text(
                                                  widget.profileModel
                                                      .followingCount
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: style.headline6),
                                              subtitle: Text("Followings",
                                                  textAlign: TextAlign.center,
                                                  style: style.titleMedium),
                                            )),
                                          ],
                                        ),
                                      ),
                                      FutureBuilder<bool>(
                                          future: _profileRepo.isFollowing(
                                              widget.profileModel.id,
                                              _authService.token!),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container();
                                            }
                                            return snapshot.data!
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20,
                                                      vertical: 8,
                                                    ),
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        toggleFollowing(
                                                            widget.profileModel
                                                                .id,
                                                            _authService
                                                                .token!);
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        minimumSize: const Size
                                                            .fromHeight(40),
                                                      ),
                                                      child: Text(
                                                        "Following",
                                                        style:
                                                            style.titleMedium,
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                MyElevatedButton(
                                                              buttonText:
                                                                  "Follow",
                                                              onPressed: () {
                                                                toggleFollowing(
                                                                    widget
                                                                        .profileModel
                                                                        .id,
                                                                    _authService
                                                                        .token!);
                                                              },
                                                              height: 30,
                                                              style: style
                                                                  .titleMedium,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: OutlinedButton(
                                                            onPressed: () {},
                                                            style: OutlinedButton
                                                                .styleFrom(
                                                                    minimumSize:
                                                                        const Size.fromHeight(
                                                                            50)),
                                                            child: Text(
                                                              "Message",
                                                              style: style
                                                                  .titleMedium,
                                                            ),
                                                          ),
                                                        ))
                                                      ],
                                                    ),
                                                  );
                                          }),
                                      Container(
                                        width: Get.width * 0.9,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                255, 240, 218, 1),
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: const [
                                              Center(
                                                  child: Text(
                                                "Upcoming giveaway on 18th June.",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18),
                                              )),
                                              Center(
                                                  child: Text(
                                                "Stay Tuned",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18),
                                              )),
                                              Center(
                                                child: Text(
                                                  "Engineer who love dancing, modelling, photography. DM me for collaboration",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: Get.height * 0.08,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Material(
                                    elevation: 3,
                                    shape: CircleBorder(),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage(Assets.profile),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  })
                ]),
              )
            ];
          },
          body: _tabSection(context, widget.profileModel),
        ),
      ),
    );
  }

  Widget _tabSection(BuildContext context, ProfileModel profileModel) {
    final _profileRepo = Get.find<ProfileRepository>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar(tabs: [
          const Tab(text: "Rolls"),
          const Tab(text: "Photos"),
          if (profileModel.status == 'VERIFIED') const Tab(text: "Giveaway"),
        ]),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: TabBarView(children: [
            ProfileReel(profileId: profileModel.id),
            Container(),
            if (profileModel.status == 'VERIFIED')
              const Center(child: Text("Giveaway")),
          ]),
        ),
      ],
    );
  }
}

class ProfileReel extends StatelessWidget {
  final int? profileId;
  ProfileReel({Key? key, this.profileId}) : super(key: key);

  final _profileRepo = Get.find<ProfileRepository>();

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<SearchController>();
    printInfo(info: "ProfileId: ${_controller.profileId}");
    return FutureBuilder<List<ReelModel>>(
        future: profileId != null
            ? _profileRepo.getReelByProfileId(profileId!, _controller.token!)
            : _profileRepo.getReelByProfileId(
                _controller.profileId!, _controller.token!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            printInfo(info: "profileReels: ${snapshot.error}");
          }
          var reels = snapshot.data!;
          printInfo(info: "Reels: $reels");
          if (reels.isEmpty) {
            return const Center(
              child: Text("No reels available"),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reels.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(SingleFeedScreen(reels[index], null));
                },
                child: CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80",
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        });
  }
}
