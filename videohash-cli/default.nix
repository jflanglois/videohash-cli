{ pyright, python3Packages, videohash }: python3Packages.buildPythonApplication {
  pname = "videohash-cli";
  version = "0.1";
  src = ./.;
  build-system = with python3Packages; [ setuptools ];
  dependencies = with python3Packages; [ argparse-dataclass validators videohash ];
  nativeBuildInputs = [ pyright ];
}
