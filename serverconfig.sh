#!/bin/bash
sudo apt update
sudo apt install make
sudo apt install -y ocaml-nox
cd /unison
NATIVE=true make
sudo cp ./src/unison /usr/local/bin
sudo cp ./src/unison-fsmonitor /usr/local/bin
mkdir /home/ubuntu/project
