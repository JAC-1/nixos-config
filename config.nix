
{ config, pkgs, ... }:

{
  # basic locale/time
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "ja_JP.UTF-8";

  # # enable systemd in initrd (helps with plymouth & fido2 support)
  # boot.initrd.systemd.enable = true; # recommended for plymouth + fido2 workflows

  # Plymouth splash (graphical boot and unlock prompt)
  # boot.plymouth.enable = true;
  # boot.plymouth.theme = "breeze"; # a common theme; change to custom themePackages if needed
  boot.initrd.luks.askpass = true; # ensure initrd prompts for LUKS password (default behaviour)
  # if using a custom plymouth theme, add it to themePackages:
  # boot.plymouth.themePackages = [ pkgs.adi1090x-plymouth-themes ];

  # kernel params (optional: "splash" can affect behaviour; use with caution)
  # boot.kernelParams = [ "quiet" "splash" ];

  # X/Wayland basics
  services.xserver.enable = true;         # enable X (some WMs need X)
  services.xserver.layout = "jp";         # X keyboard layout
  services.xserver.xkbModel = "jp106";    # keyboard model (jp106)
  services.xserver.xkbVariant = "";       # variant (if any)
  services.xserver.xkbOptions = "terminate:ctrl_alt_bksp";

  # Or, for Wayland-only WMs like sway/hyprland, install the compositor packages:
  # environment.systemPackages = with pkgs; [
  #   neovim
  #   git
  #   wget
  # ];

  # display manager (pick one you like)
  # services.displayManager.sddm.enable = true; # or gdm/lightdm etc.
  # if you prefer a minimal approach, enable auto login or a simple WM session instead

  # Stylix options (minimal example — stylix is enabled by the module included in the flake)
  stylix = {
    enable = true;
    autoEnable = true; # try to apply theme automatically
    # Example: set a base16 scheme (requires the scheme to exist in pkgs)
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };

  # Home-Manager will be available (we included the module in the flake)
}
