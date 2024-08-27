{ pkgs }: {
  deps = [
    pkgs.haskellPackages.bindings-linux-videodev2
    pkgs.python311Packages.get-video-properties
    pkgs.haskellPackages.amazonka-kinesis-video-signaling
    pkgs.python311Packages.mypy-boto3-kinesis-video-media
    pkgs.python312Packages.types-aiobotocore-kinesis-video-archived-media
    pkgs.mpvScripts.cutter
    pkgs.video2midi
    pkgs.video-trimmer
    pkgs.octavePackages.video
    pkgs.mpvScripts.videoclip
    pkgs.sudo
    pkgs.flutter322
    pkgs.flutter313
    pkgs.flutterPackages.stable
    pkgs.flutter
    pkgs.flutter316
  ];
}