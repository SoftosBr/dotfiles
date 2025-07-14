#!/bin/bash 
  ARG=$1
  
  redshift -x

  if [[ "$ARG" == "on"  ]]; then
      redshift -O 3750
      echo "Redshift enabled (3750K)"
  elif [[ "$ARG" == "off"  ]]; then
      echo "Redshift disabled"
  elif [[ "$ARG" =~ ^[0-9]+$ ]]; then
      redshift -O "$ARG"
      echo "Redshift enabled ($ARG K)"
  else
      echo "Use: $0 on | off | [temperature_ex: 4000]"
  fi      
