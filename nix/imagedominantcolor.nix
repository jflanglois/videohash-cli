{ python3Packages, fetchPypi }: python3Packages.buildPythonPackage rec {
  pname = "imagedominantcolor";
  version = "1.0.1";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-83eQ37UkAqY2Ix6OChFI8kGZDU/3X2tuf4OIhf/vcHk=";
  };
  build-system = with python3Packages; [ setuptools ];
  dependencies = with python3Packages; [ pillow ];
  postPatch = ''
    substituteInPlace imagedominantcolor/dominantcolor.py \
      --replace-warn "Image.ANTIALIAS" "Image.LANCZOS"
  '';
}

