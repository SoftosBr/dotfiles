# NixOS dotfiles

Configuração declarativa de NixOS com Flakes, Home Manager, Hyprland e Dux Shell (DMS).

## Antes da primeira ativação

1. Ajuste `networking.hostName`, usuário, monitores e arquitetura se necessário.
2. No NixOS de destino, gere o arquivo específico do hardware:

   ```sh
   sudo nixos-generate-config --show-hardware-config > nix/hosts/nixos/hardware-configuration.nix
   ```

3. Revise o diff sem construir nada:

   ```sh
   git diff main...nix-dms
   ```

4. Quando decidir aplicar, use:

   ```sh
   sudo nixos-rebuild switch --flake .#nixos
   ```

O DMS é iniciado por um serviço systemd de usuário e substitui Waybar, Rofi,
Dunst, Hyprpaper e Hyprlock. Ele também é responsável por gerar e manter a
configuração Lua do Hyprland, incluindo gaps, monitores, input e atalhos.

## Organização

```text
nix/hosts/nixos/
├── default.nix                 # agrega os módulos do sistema
├── hardware-configuration.nix  # específico da máquina
└── modules/
    ├── audio.nix
    ├── base.nix
    ├── boot.nix
    ├── desktop.nix
    ├── networking.nix
    ├── packages.nix
    └── user.nix

nix/home/
├── henrique.nix                # agrega os módulos do usuário
└── modules/
    ├── dms.nix
    ├── files.nix
    ├── kitty.nix
    ├── packages.nix
    └── shell.nix

```

As configurações declarativas ficam nos módulos Nix. O diretório
`~/.config/hypr` não é gerenciado pelo Home Manager para continuar gravável
pelo DMS.

O Zsh usa Powerlevel10k instalado pelo Nix e reutiliza declarativamente a
configuração anterior, armazenada em `nix/home/assets/p10k.zsh`.

## Primeiro login

Após a primeira ativação, abra um terminal na sessão Hyprland e execute:

```sh
dms setup
```

Depois encerre a sessão e entre novamente. Esse comando cria o
`~/.config/hypr/hyprland.lua` e os fragmentos gerenciáveis pelo DMS. A partir
daí, altere gaps, aparência, monitores, input e atalhos pela interface do DMS.
