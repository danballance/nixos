{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  home.stateVersion = "25.05";
  home.packages = [ pkgs.claude-code ];
  programs.home-manager.enable = true;

  stylix.targets.vscode.profileNames = [
    "default"
    "js"
  ];

  programs.git = {
    enable = true;
    extraConfig = {
      user.name = "Anoni Mouse";
      user.email = "nixprivacy@pm.me";
      init.defaultBranch = "main";
    };
  };

  programs.nixvim = {
    enable = true;
    plugins.lualine.enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.firefoxpwa];
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Preferences = {
        "browser.tabs.warnOnClose" = {
          "Value" = false;
          "Status" = "locked";
        };
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    
    profiles = {
      js = {
        extensions = with pkgs.vscode-marketplace; [
          anthropic.claude-code
          esbenp.prettier-vscode
          pkief.material-icon-theme
          redhat.vscode-yaml
          vitest.explorer
        ];
        userSettings = {
          "editor.formatOnSave" = true;
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
        };
      };
    };
  };

}
