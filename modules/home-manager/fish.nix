{ ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      set -gx EDITOR nvim
    '';
    plugins = [];
    shellAliases = {
      cat = "bat";
      ls = "lsd";
      find = "fd";
      ps = "procs";
    };
		
		functions = {

      nixinfo = ''
        function nixinfo --description "Provides basic info about the NixOS envrionment"

          for dir in (string split : -- $XDG_CONFIG_DIRS)
            if test -d "$dir"
              set_color cyan; echo "=== $dir ==="; set_color normal
              # use the binary directly to bypass any ls aliasing
              command lsd --tree --depth 2 -a --group-dirs first --classify "$dir"
              echo
            else
              set_color yellow; echo "Missing: $dir"; set_color normal
            end
          end

					set_color cyan
					echo "/etc/profiles/per-user/anoni/"
					ls -lah /etc/profiles/per-user/anoni/
					echo

					set_color cyan
					echo "~/.config/"
					ls -lah ~/.config/
        end
      '';
		};
  };
}

