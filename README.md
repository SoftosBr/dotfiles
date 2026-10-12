# Dotfiles para Arch Linux no WSL

Configuração de terminal e desenvolvimento para **Arch Linux no WSL**.
Execute com um usuário comum com acesso ao `sudo` e conexão à internet:

```bash
./install.sh
```

O instalador pode ser chamado de qualquer diretório. Ele atualiza o sistema
com `pacman -Syu`, instala os pacotes e solicita as confirmações do gerenciador
de pacotes e as credenciais necessárias. Não execute o script com sudo.

## O que é instalado

- Zsh e Oh My Zsh com Powerlevel10k e a configuração visual anterior.
- Plugins `git`, `zsh-autosuggestions` e `zsh-syntax-highlighting`.
- Stow, yay, neofetch, unzip, zip, curl, Git e manuais.
- fzf, ripgrep, bat, htop, btop, Neovim e lazygit.
- `base-devel` (incluindo GCC e Make), Python e pip.
- nvm v0.40.4, Node.js LTS e npm. Node/npm são instalados pelo nvm.
- Fontes Noto, Noto CJK, Noto Emoji, Hack Nerd, Fira Code,
  Fira Code Nerd e símbolos Nerd Fonts.

O yay é compilado a partir do AUR quando necessário; neofetch é instalado
pelo yay. As fontes são instaladas dentro do Linux. Para usá-las no Windows
Terminal, instale também a fonte desejada no Windows e selecione-a no perfil.

## Configuração e novas execuções

O Stow cria os links de `~/.zshrc` e `~/.p10k.zsh` para os arquivos em
`zsh/` deste repositório.
Uma configuração existente que aponte para outro lugar é movida para um
diretório exclusivo `~/.zshrc-backup.*` ou `~/.p10k.zsh-backup.*` antes da criação do link.
Mantenha o repositório no mesmo caminho após instalar.

Novas execuções reutilizam Oh My Zsh, Powerlevel10k, plugins, nvm e yay existentes, atualizam os
pacotes do sistema e instalam a LTS atual de Node, definindo-a como padrão.
A configuração Zsh restaura o instant prompt e o visual já salvo do p10k,
os plugins, a seleção automática de Node por `.nvmrc`, o alias `nvm-default`
e a regra anterior de identidade Git para caminhos contendo `work`.
As referências a pywal e ao script de redshift foram removidas.
Selecione uma Nerd Font no Windows Terminal para exibir os ícones do prompt.

Ao terminar, abra outra sessão do WSL ou execute `exec zsh`.

Este repositório não instala interface gráfica, display manager, drivers de
vídeo, sistema de áudio ou tmux. A remoção das configurações antigas do
repositório não desinstala pacotes nem limpa arquivos já instalados no sistema.

Referências: [nvm](https://github.com/nvm-sh/nvm),
[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh).
