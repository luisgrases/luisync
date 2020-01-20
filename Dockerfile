FROM ubuntu:18.04
RUN apt-get update && apt-get install -y nano git build-essential wget ocaml-nox build-essential zip unzip
COPY ./packer_1.5.1_linux_amd64.zip ./
RUN unzip ./packer_1.5.1_linux_amd64.zip
RUN mv packer /usr/local/bin
COPY ./unison.zip /home/ubuntu/unison.zip
RUN unzip /home/ubuntu/unison.zip
RUN cd /unison-master && NATIVE=true make
RUN cp /unison-master/src/unison /usr/local/bin
RUN cp /unison-master/src/unison-fsmonitor /usr/local/bin
RUN chmod 777 /home/ubuntu/unison.zip
