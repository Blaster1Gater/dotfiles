{ config, pkgs, ... }:
let
  # Apontamos diretamente para 'gnugrep' em vez de 'grep'
  grep = pkgs.gnugrep;
  # 1. Declare os Flatpaks que você *deseja* no seu sistema
  desiredFlatpaks = [
    "org.musescore.MuseScore"
    "com.orama_interactive.Pixelorama"
    "de.haeckerfelix.Shortwave"
  ];
in {
  system.userActivationScripts.flatpakManagement = {
    text = ''
      # 2. Certifique-se de que o repositório Flathub esteja adicionado
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo

      # 3. Obtenha os Flatpaks atualmente instalados
      installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

      # 4. Remova quaisquer Flatpaks que NÃO estejam na lista desejada
      for installed in $installedFlatpaks; do
        if ! echo ${toString desiredFlatpaks} | ${grep}/bin/grep -q $installed; then
          echo "Removendo $installed porque não está na lista desiredFlatpaks."
          ${pkgs.flatpak}/bin/flatpak uninstall -y --noninteractive $installed
        fi
      done

      # 5. Instale ou reinstale os Flatpaks que você DESEJA
      for app in ${toString desiredFlatpaks}; do
        echo "Garantindo que $app esteja instalado."
        ${pkgs.flatpak}/bin/flatpak install -y flathub $app
      done

      # 6. Remova Flatpaks não utilizados
      ${pkgs.flatpak}/bin/flatpak uninstall --unused -y

      # 7. Atualize todos os Flatpaks instalados
      ${pkgs.flatpak}/bin/flatpak update -y
    '';
  };
}
