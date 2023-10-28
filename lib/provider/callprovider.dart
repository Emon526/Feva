import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../consts/consts.dart';

class CallProvider extends ChangeNotifier {
  CallProvider() {
    initEngine();
  }
  bool isTokenExpiring = true;
  bool _hiringclicked = false;
  bool get hiringclicked => _hiringclicked;
  set hiringclicked(value) {
    _hiringclicked = value;
    notifyListeners();
  }

  bool _isJoined = false;
  bool get isJoined => _isJoined;
  set isJoined(value) {
    _isJoined = value;
    notifyListeners();
  }

  bool _openMicrophone = true;
  bool get openMicrophone => _openMicrophone;
  set openMicrophone(value) {
    _openMicrophone = value;
    notifyListeners();
  }

  bool _enableSpeakerphone = true;
  bool get enableSpeakerphone => _enableSpeakerphone;
  set enableSpeakerphone(value) {
    _enableSpeakerphone = value;
    notifyListeners();
  }

  bool _lookingjobsclicked = false;
  bool get lookingjobsclicked => _lookingjobsclicked;
  set lookingjobsclicked(value) {
    _lookingjobsclicked = value;
    notifyListeners();
  }

  final _hiringFormKey = GlobalKey<FormState>();
  get hiringFormKey => _hiringFormKey;
  bool _ishiring = false;
  bool get ishiring => _ishiring;
  set ishiring(bool value) {
    _ishiring = value;
    notifyListeners();
  }

  final _lookingforjobsFormKey = GlobalKey<FormState>();
  get lookingforjobsFormKey => _lookingforjobsFormKey;

  String _country = 'Canada';
  String get country => _country;
  set country(String value) {
    _country = value;
    notifyListeners();
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    notifyListeners();
  }

  File? _image;
  File? get image => _image;
  set image(File? value) {
    _image = value;
    notifyListeners();
  }

  String _skill = '';
  String get skill => _skill;
  set skill(String value) {
    _skill = value;
    notifyListeners();
  }

  late RtcEngine _engine;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  Future<void> initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: Consts.agoraAppId,
    ));

    _rtcEngineEventHandler = RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        log("local user ${connection.localUid} joined");

        isJoined = true;
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        log("remote user $remoteUid joined");
      },
      onError: (ErrorCodeType err, String msg) {
        log('[onError] err: $err, msg: $msg');
      },
      onUserOffline: (RtcConnection connection, int remoteUid,
          UserOfflineReasonType reason) {
        log("remote user $remoteUid left channel");
      },
      onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
        log('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        log('[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        // isJoined = false;

        isJoined = false;
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
    await _engine.adjustPlaybackSignalVolume(100);
  }

  leaveChannel() async {
    await _engine.leaveChannel();
    isJoined = false;
    openMicrophone = true;
    enableSpeakerphone = true;
  }

  Future<void> fetchToken(int uid, String tokenRole) async {
    // Prepare the Url
    String url =
        '${Consts.agoraTokenApi}/rtc/$_country$_skill/$tokenRole/uid/${uid.toString()}?expiry=${Consts.tokenExpireTime.toString()}';
    log(url);
    // Send the request
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      Map<String, dynamic> json = jsonDecode(response.body);
      String newToken = json['rtcToken'];
      debugPrint('Token Received: $newToken');
      log('Token Received: $newToken');
      // Use the token to join a channel or renew an expiring token
      setToken(newToken, uid);
    } else {
      // If the server did not return an OK response,
      // then throw an exception.
      throw Exception(
          'Failed to fetch a token. Make sure that your server URL is valid');
    }
  }

  void setToken(String newToken, int uid) async {
    _token = newToken;

    if (isTokenExpiring) {
      // Renew the token
      _engine.renewToken(_token);
      isTokenExpiring = false;
      log("Token renewed");
    } else {
      // Join a channel.
      log("Token received, joining a channel...");
      // _joinChannel();
      // await _engine.joinChannel(
      //   token: token,
      //   channelId: '$_country$_skill',
      //   uid: uid,
      //   options: const ChannelMediaOptions(
      //       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      //       clientRoleType: ClientRoleType.clientRoleBroadcaster),
      // );
    }
  }

  joinChannel() async {
    if (await Permission.microphone.isDenied ||
        await Permission.microphone.isLimited ||
        await Permission.microphone.isPermanentlyDenied ||
        await Permission.microphone.isProvisional ||
        await Permission.microphone.isRestricted) {
      await Permission.microphone.request();
    }

    await _engine.joinChannel(
        token: Consts.agoraToken,
        channelId: '$_country$_skill',
        uid: 0,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
  }

  switchMicrophone() async {
    await _engine.enableLocalAudio(!_openMicrophone);
    openMicrophone = !_openMicrophone;
  }

  switchSpeakerphone() async {
    await _engine.setEnableSpeakerphone(!_enableSpeakerphone);

    enableSpeakerphone = !_enableSpeakerphone;
  }
}
