#!/bin/bash

# Função para instalar o clangd
install_clangd() {
  echo "Atualizando lista de pacotes..."
  sudo apt update

  echo "Instalando clangd..."
  sudo apt install -y clangd

  echo "clangd instalado com sucesso."
}

# Função para instalar a FiraMono Nerd Font
install_firamono_nerd_font() {
  echo "Criando diretório temporário..."
  TEMP_DIR=$(mktemp -d)

  echo "Baixando FiraMono Nerd Font..."
  wget -O "$TEMP_DIR/FiraMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip"

  echo "Extraindo arquivos..."
  unzip "$TEMP_DIR/FiraMono.zip" -d "$TEMP_DIR"

  echo "Instalando fontes..."
  mkdir -p ~/.local/share/fonts
  # Procura por arquivos .ttf e .otf e os move para o diretório de fontes
  find "$TEMP_DIR" -type f \( -iname "*.ttf" -o -iname "*.otf" \) -exec mv {} ~/.local/share/fonts/ \;

  echo "Atualizando cache de fontes..."
  fc-cache -f -v

  echo "Removendo arquivos temporários..."
  rm -rf "$TEMP_DIR"

  echo "FiraMono Nerd Font instalada com sucesso."
}

# Executando as funções
install_clangd
install_firamono_nerd_font

echo "Todas as instalações foram concluídas."

