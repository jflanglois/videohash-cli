{ python3Packages, fetchPypi, ffmpeg, imagedominantcolor }: python3Packages.buildPythonPackage rec {
  pname = "videohash";
  version = "3.0.1";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ZLo4doBMWEpK4ixw1HCO6gjlWcLqnOinkmoolLTzjC8=";
  };
  build-system = with python3Packages; [ setuptools ];
  dependencies = with python3Packages; [
    imagehash
    pillow
    imagedominantcolor
    yt-dlp
  ];
  postPatch = ''
    substituteInPlace videohash/videoduration.py videohash/framesextractor.py \
      --replace-warn "which(\"ffmpeg\")" "\"${ffmpeg}/bin/ffmpeg\""
    substituteInPlace videohash/collagemaker.py \
      --replace-warn "Image.ANTIALIAS" "Image.LANCZOS"
  '';
}
