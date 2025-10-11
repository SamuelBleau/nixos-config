{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc gnumake cmake clang
    nodejs yarn
    python3
    docker
  ];

  virtualisation.docker.enable = true;
  users.users.meeast.extraGroups = [ "docker" ];
}
