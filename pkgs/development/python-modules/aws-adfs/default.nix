{
  lib,
  boto3,
  botocore,
  buildPythonPackage,
  click,
  configparser,
  fetchFromGitHub,
  fido2,
  lxml,
  poetry-core,
  pyopenssl,
  pytestCheckHook,
  pythonOlder,
  requests,
  requests-kerberos,
  toml,
}:

buildPythonPackage rec {
  pname = "aws-adfs";
  version = "2.11.2";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "venth";
    repo = "aws-adfs";
    tag = "v${version}";
    hash = "sha256-ZzQ92VBa8CApd0WkfPrUZsEZICK2fhwmt45P2sx2mK0=";
  };

  build-system = [
    poetry-core
  ];

  pythonRelaxDeps = [
    "configparser"
    "requests-kerberos"
  ];

  dependencies = [
    boto3
    botocore
    click
    configparser
    fido2
    lxml
    pyopenssl
    requests
    requests-kerberos
  ];

  nativeCheckInputs = [
    pytestCheckHook
    toml
  ];

  preCheck = ''
    export HOME=$(mktemp -d);
  '';

  pythonImportsCheck = [ "aws_adfs" ];

  meta = with lib; {
    description = "Command line tool to ease AWS CLI authentication against ADFS";
    homepage = "https://github.com/venth/aws-adfs";
    changelog = "https://github.com/venth/aws-adfs/releases/tag/v${version}";
    license = licenses.psfl;
    maintainers = with maintainers; [ bhipple ];
    mainProgram = "aws-adfs";
  };
}
