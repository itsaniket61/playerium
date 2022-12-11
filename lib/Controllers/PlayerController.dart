import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio_background/just_audio_background.dart';
import 'package:palette_generator/palette_generator.dart';

class PlayerController extends GetxController {
  var player = AudioPlayer().obs;
  List playlistdata = [].obs;
  List<AudioSource> playlist = [];
  var concatPlaylist;
  var adCount = 0.obs;
  var bgColor = Color(0xdf000000).obs;
  var loading = false.obs;

  getTrack(vid) async {
    loading.value = true;
    loading.refresh();
    if (adCount == 12) {
      adCount.value = 0;
      _initInterstialAd();
      printError(info: "Ad Called!!!");
    } else {
      adCount++;
    }
    try {
      var base =
          await http.get(Uri.parse('https://playerium.itsaniket61.repl.co/'));
      String baseurl = base.body;
      printError(info: baseurl);
      var res = await http.get(Uri.parse("${baseurl}/get?vid=${vid}"));
      var data = jsonDecode(res.body);
      if (data['author'].toString().contains('- Topic') ||
          playlistdata.contains(data)) {
        return null;
      }
      return data;
    } catch (e) {
      Get.snackbar("Error", "id is ${vid}");
    }
  }

  play(vid) async {
    await addToQueue(vid);
    concatPlaylist = ConcatenatingAudioSource(children: playlist);
    player.value.setAudioSource(concatPlaylist);
    player.value.play();
  }

  addToQueue(vid) async {
    var data = await getTrack(vid);
    var d = {
      "vid": vid,
      "title": data["title"],
      "cover": data["cover"],
      "author": data["author"],
      "related": data["related"],
      'src': data["src"]
    };
    if (data == null || playlistdata.contains(d)) {
      return;
    }
    concatPlaylist.add(AudioSource.uri(
      Uri.parse(data['src']),
      tag: MediaItem(
        id: vid,
        album: data['title'],
        title: data['title'],
        artUri: Uri.parse(data['cover']),
      ),
    ));
    playlistdata.add(d);
  }

  playNext() async {
    var i = player.value.currentIndex!;
    addRelatedQueue(playlistdata[i]['vid']);
    player.value.seekToNext();
  }

  playPrevious() {
    player.value.seekToPrevious();
  }

  clearPlaylist() async {
    playlist.clear();
    playlistdata.clear();
    concatPlaylist =
        ConcatenatingAudioSource(useLazyPreparation: true, children: playlist);
    await player.value.setAudioSource(concatPlaylist);
  }

  addRelatedQueue(vid) async {
    if (playlistdata.length <= player.value.currentIndex! + 4) {
      var data = await getTrack(vid);
      for (var i = 0; i < 5; i++) {
        addToQueue(data["related"][i]['id']);
      }
    }
  }

  _initInterstialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-4911910001881650/8902840260',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            ad.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  Future<Color> getImagePalette() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(playlistdata[player.value.currentIndex!]['cover']));
    bgColor.value = paletteGenerator.darkVibrantColor!.color;
    bgColor.refresh();
    refresh();
    return paletteGenerator.darkVibrantColor!.color;
  }
}
