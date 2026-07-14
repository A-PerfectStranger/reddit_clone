import 'dart:math';
import '../models/post_model.dart';
import '../models/community_model.dart';
import '../models/comment_model.dart';
import '../models/chat_model.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';
import '../core/constants/app_constants.dart';

/// Fuente centralizada de datos simulados (mock data).
/// Genera contenido pseudo-aleatorio pero determinista para que
/// las listas de la app se vean realistas sin depender de una API.
class MockData {
  MockData._();

  static final Random _rng = Random(42);

  static final UserModel currentUser = UserModel(
    id: 'u0',
    username: 'Empty-Object-5967',
    avatarSeed: 'me',
    karma: 1,
    accountCreated: DateTime.now().subtract(const Duration(days: 30)),
  );

  static const List<String> _communityNames = [
    'AskReddit',
    'AITAH',
    'dadjokes',
    'mildlyinteresting',
    'interestingasfuck',
    'GuysBeingDudes',
    'instantbarbarians',
    'ContagiousLaughter',
    'freefolk',
    'SipsTea',
    'tattooadvice',
    'flutterdev',
    'ProgrammerHumor',
    'science',
    'todayilearned',
    'movies',
    'gaming',
    'technology',
    'worldnews',
    'sports',
    'food',
    'travel',
    'photography',
    'art',
    'music',
    'books',
    'fitness',
    'personalfinance',
    'relationship_advice',
    'LifeProTips',
    'DIY',
    'gardening',
    'cats',
    'dogs',
    'aww',
    'nba',
    'soccer',
    'formula1',
    'space',
    'history',
  ];

  static const List<String> _titles = [
    'Wait a damn minute',
    'What is a hidden gem that you are shocked is completely free?',
    'Did I ruin this??? Be honest',
    'My cat just did something I have never seen before',
    'This view from my hotel room this morning',
    'TIL that octopuses have three hearts',
    'Finally finished my first solo project after 6 months',
    'What is something that instantly makes you trust someone?',
    'My grandma\'s handwriting from 1962',
    'This is the cleanest engine bay I have ever seen',
    'Update: it worked out better than I expected',
    'Unpopular opinion: pineapple belongs on pizza',
    'How this tiny shop still survives downtown is beyond me',
    'What career choice changed your life for the better?',
    'The way the light hit the room this afternoon',
    'AITA for telling my roommate to clean up after himself?',
    'This bridge took 4 years to build and it shows',
    'My dog refuses to walk past this one house',
    'Just hit a personal record after a year of training',
    'Explain like I am 5: how does WiFi actually work?',
  ];

  static const List<String> _bodies = [
    'Not sure if this belongs here but I thought it was worth sharing with everyone.',
    'Been lurking for years, finally decided to post something myself.',
    'Happened yesterday and I am still thinking about it honestly.',
    'Curious what this community thinks, drop your opinions below.',
    'Long time reader, first time poster. Be gentle.',
    'What do you think about this?',
    'I have a question about this.',
    'This is a great post.',
  ];

  static const List<String> _commentTexts = [
    'This is exactly what I needed to see today.',
    'Underrated comment right here.',
    'Wait this actually makes a lot of sense.',
    'Source? Not doubting, just curious.',
    'Same thing happened to me last week.',
    'Take my upvote and get out.',
    'This aged well.',
    'Username checks out.',
    'I came here to say this.',
    'Honestly did not expect to relate this much.',
  ];

  static const List<String> _chatMessages = [
    'Hey, did you see that post?',
    'lol that is wild',
    'sent you the link',
    'thanks for the help earlier',
    'are you going tonight?',
    'check this out',
    'omg no way',
    'let me know when you are free',
    'good point actually',
    'see you there',
  ];

  static List<CommunityModel> generateCommunities() {
    return List.generate(AppConstants.communityCount, (i) {
      final name = _communityNames[i % _communityNames.length] +
          (i >= _communityNames.length ? '$i' : '');
      return CommunityModel(
        id: 'c$i',
        name: name,
        iconSeed: name,
        members: 500 + _rng.nextInt(4500000),
        description:
            'Comunidad dedicada a $name. Comparte, discute y descubre contenido relacionado.',
        joined: _rng.nextBool(),
      );
    });
  }

  static List<CommentModel> _generateComments(int count) {
    return List.generate(count, (i) {
      return CommentModel(
        id: 'cm$i-${_rng.nextInt(99999)}',
        author: 'user_${_rng.nextInt(9999)}',
        avatarSeed: 'a${_rng.nextInt(500)}',
        text: _commentTexts[_rng.nextInt(_commentTexts.length)],
        votes: _rng.nextInt(3000),
        createdAt:
            DateTime.now().subtract(Duration(minutes: _rng.nextInt(2000))),
        depth: _rng.nextInt(2),
      );
    });
  }

  static List<PostModel> generatePosts() {
    const communities = _communityNames;
    return List.generate(AppConstants.postCount, (i) {
      final hasImage = _rng.nextDouble() < 0.55;
      final body = _bodies[_rng.nextInt(_bodies.length)];
      final community = communities[_rng.nextInt(communities.length)];
      return PostModel(
        id: 'p$i',
        author: 'user_${_rng.nextInt(9999)}',
        avatarSeed: 'a${_rng.nextInt(500)}',
        community: community,
        communityIconSeed: community,
        createdAt:
            DateTime.now().subtract(Duration(minutes: _rng.nextInt(4000))),
        title: _titles[_rng.nextInt(_titles.length)],
        bodyText: body,
        imageSeed: hasImage ? 'post$i' : null,
        upvotes: _rng.nextInt(50000),
        commentCount: _rng.nextInt(5000),
        comments: _generateComments(5 + _rng.nextInt(15)),
      );
    });
  }

  static List<ChatModel> generateChats() {
    return List.generate(AppConstants.chatCount, (i) {
      final unread = _rng.nextDouble() < 0.3 ? 1 + _rng.nextInt(9) : 0;
      return ChatModel(
        id: 'ch$i',
        name: 'user_${_rng.nextInt(9999)}',
        avatarSeed: 'chat$i',
        lastMessage: _chatMessages[_rng.nextInt(_chatMessages.length)],
        time: DateTime.now().subtract(Duration(minutes: _rng.nextInt(4000))),
        unreadCount: unread,
      );
    });
  }

  static List<NotificationModel> generateNotifications() {
    const types = NotificationType.values;
    const messages = [
      'upvoted your post',
      'commented on your post: "This is great!"',
      'mentioned you in a comment',
      'started following you',
      'has a new post you might like',
    ];
    return List.generate(AppConstants.notificationCount, (i) {
      final type = types[_rng.nextInt(types.length)];
      return NotificationModel(
        id: 'n$i',
        type: type,
        username: 'r/${_communityNames[_rng.nextInt(_communityNames.length)]}',
        message: messages[type.index],
        time: DateTime.now().subtract(Duration(minutes: _rng.nextInt(3000))),
        read: _rng.nextDouble() < 0.4,
      );
    });
  }
}
