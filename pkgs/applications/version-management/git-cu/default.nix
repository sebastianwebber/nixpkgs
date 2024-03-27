{
  lib
, pythonPackages
, fetchPypi
, git
}:

pythonPackages.buildPythonApplication rec {
    pname = "git-cu";
    version = "0.5.0";
    format = "pyproject";

    disabled = pythonPackages.pythonOlder "3.6";

    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "b38b3c2aeeb58c2525cfe71cad7168394c5f8b43817e2eeb4efffabcb81ba148";
    };

    propagatedBuildInputs = [
      git
    ];

    postPatch = ''
      substituteInPlace pyproject.toml \
      --replace poetry.masonry.api poetry.core.masonry.api \
      --replace "poetry>=" "poetry-core>="
    '';

    nativeBuildInputs = with pythonPackages; [
      poetry-core
    ];

    meta = with lib; {
      changelog = "https://gitlab.com/3point2/git-cu/-/tags/v${version}";
      description = "git-cu helps keep your local git repositories organized by cloning them into a directory structure based on their URL.";
      homepage = "https://gitlab.com/3point2/git-cu";
      license = licenses.gpl3;
      maintainer = "3point2";
      platforms = platforms.all;
      mainProgram = "git-up";
    };
}
