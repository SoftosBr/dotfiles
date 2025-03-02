#!/bin/bash

# Matar qualquer instância anterior da Polybar
killall polybar

# Esperar para garantir que o sistema tenha tempo de detectar os monitores
sleep 1

# Iniciar a Polybar para todos os monitores
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload skybar &
done
