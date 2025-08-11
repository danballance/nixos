{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.kiro.packages.x86_64-linux.default
  ];
}
