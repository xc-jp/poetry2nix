{ poetry2nix, python312, runCommand }:
let
  env = poetry2nix.mkPoetryEnv {
    python = python312;
    projectDir = ./.;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
  };
in
runCommand "mk-poetry-packages-partition-test"
{ } ''
  ${env}/bin/python -c 'import watchdog; print(watchdog.__name__)'
  touch $out
''
