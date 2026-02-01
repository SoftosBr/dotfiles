
studies_folder="$HOME/studies"

if [ ! -d "$studies_folder"  ]; then
  echo "\n Studies folder doesn't exist"
  exit 1
fi	

if cd "$studies_folder"; then 
  rm -rf *
fi


