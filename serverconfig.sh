#!/bin/bash
sudo apt update
sudo apt-get update && sudo apt-get install -y nano make git build-essential wget ocaml-nox build-essential zip unzip
sudo unzip /home/ubuntu/unison.zip
cd /home/ubuntu/unison-master && sudo NATIVE=true make
sudo cp ./src/unison /usr/local/bin
sudo cp ./src/unison-fsmonitor /usr/local/bin
mkdir /home/ubuntu/project
