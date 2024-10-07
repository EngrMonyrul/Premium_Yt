enum MediaOptions {
  video,
  audio,
  pip;

  bool get isVideo => this == video;

  bool get isAudio => this == audio;

  bool get isPip => this == pip;
}
