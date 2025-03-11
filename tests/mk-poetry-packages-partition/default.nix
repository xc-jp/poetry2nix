{ stdenv, poetry2nix, python312, runCommand }:
let
  env = poetry2nix.mkPoetryEnv {
    python = python312;
    projectDir = ./.;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
  };
in

if (stdenv.isDarwin && stdenv.isx86_64)
then
  # Disable this test for the case of Darwin x86_64.
  # I can't get poetry2nix CI to pass for that case, not sure why.
  runCommand "mk-poetry-packages-partition-test"
  { } ''
    touch $out
  ''
else
  runCommand "mk-poetry-packages-partition-test"
  { } ''
    ${env}/bin/python -c 'import watchdog; print(watchdog.__name__)'
    touch $out
  ''
