FROM ubuntu:18.04
RUN apt-get update && apt-get install -y nano git build-essential wget ocaml-nox build-essential zip unzip
COPY ./packer_1.5.1_linux_amd64.zip ./
RUN unzip ./packer_1.5.1_linux_amd64.zip
RUN mv packer /usr/local/bin
ADD ./unison ./unison
RUN cd ./unison && NATIVE=true make
RUN cp ./unison/src/unison /usr/local/bin
RUN cp ./unison/src/unison-fsmonitor /usr/local/bin
COPY ./aws-image-template.json /home/ubuntu/
COPY ./serverconfig.sh /home/ubuntu/
