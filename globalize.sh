#!/bin/bash
read -p "Do you want to make DVC global? [Y/n] " response

# Default to "Y" if empty
response=${response:-Y}

if [[ "$response" == "y" || "$response" == "Y" ]]; then
    sudo cp dvc.lua /usr/local/bin/dvc
    echo "DVC installed globally."
else
    echo "Exiting"
fi

