FROM ubuntu:18.04
RUN apt-get update && apt-get install -y nano git build-essential wget ocaml-nox build-essential
RUN git clone https://github.com/bcpierce00/unison.git && cd unison && NATIVE=true make
RUN cp ./unison/src/unison /usr/local/bin
RUN cp ./unison/src/unison-fsmonitor /usr/local/bin
COPY ./build_aws_image.sh /home/ubuntu/
