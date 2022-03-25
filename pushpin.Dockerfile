FROM debian:bullseye-slim
RUN apt-get update
RUN apt-get install make g++ pkg-config rustc qtbase5-dev libzmq3-dev condure zurl -y
COPY ./pushpin /home/pushpin
WORKDIR /home/pushpin
RUN ./configure && make
RUN apt-get remove make g++ pkg-config rustc qtbase5-dev libzmq3-dev -y
RUN apt-get autoremove -y
CMD ["./pushpin"]