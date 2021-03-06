{ stdenv, lib, buildPythonPackage, isPy3k, fetchPypi
, mock
, meld3
, pytest
, setuptools
}:

buildPythonPackage rec {
  pname = "supervisor";
  version = "4.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "64082ebedf6d36ff409ab2878f1aad5c9035f916c5f15a9a1ec7dffc6dfbbed8";
  };

  # wants to write to /tmp/foo which is likely already owned by another
  # nixbld user on hydra
  doCheck = !stdenv.isDarwin;
  checkInputs = [ mock pytest ];
  checkPhase = ''
    pytest
  '';

  propagatedBuildInputs = [ meld3 setuptools ];

  meta = with lib; {
    description = "A system for controlling process state under UNIX";
    homepage = "http://supervisord.org/";
    license = licenses.free; # http://www.repoze.org/LICENSE.txt
    maintainers = with maintainers; [ zimbatm ];
  };
}
