{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = false;
    profiles = {
      js = {
        extensions = with pkgs.vscode-marketplace; [
					# anthropic.claude-code
          esbenp.prettier-vscode
          redhat.vscode-yaml
          vitest.explorer
          mkhl.direnv
        ];
        userSettings = {
          "editor.formatOnSave" = true;
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "editor.tabSize" = 2;
        };
      };
      rust = {
        extensions = with pkgs.vscode-marketplace; [
					# anthropic.claude-code
          redhat.vscode-yaml
          jnoortheen.nix-ide
          tamasfe.even-better-toml
          rust-lang.rust-analyzer
          mkhl.direnv
        ];
        userSettings = {
          "editor.tabSize" = 2;
        };
      };
      python = {
        extensions = with pkgs.vscode-marketplace; [
					#anthropic.claude-code
          redhat.vscode-yaml
          jnoortheen.nix-ide
          tamasfe.even-better-toml
          mkhl.direnv
          ms-python.python
          ms-python.debugpy
          ms-python.vscode-pylance
          charliermarsh.ruff
        ];
        userSettings = {
          "editor.formatOnSave" = true;
          "[python]" = {
            "editor.defaultFormatter" = "charliermarsh.ruff";
          };
          "editor.tabSize" = 4;
          "python.languageServer" = "Pylance";
          "python.analysis.autoImportCompletions" = true;
        };
      };
    };
  };
}

