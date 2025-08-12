{ ... }:
{
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "anoni" ];
        commands = [ "ALL" ];
      }
    ];
  };
}

