#!/bin/bash
sudo apt update
sudo apt install make
sudo apt install -y ocaml-nox
git clone https://github.com/bcpierce00/unison.git
cd unison
NATIVE=true make
sudo cp ./src/unison /usr/local/bin
sudo cp ./src/unison-fsmonitor /usr/local/bin
mkdir /home/ubuntu/project
