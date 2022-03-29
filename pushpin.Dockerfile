FROM debian:bullseye-slim
WORKDIR /home
RUN ln -s /usr/local/bin/dpkg-split /usr/local/sbin/dpkg-split \
        && ln -s /usr/local/bin/dpkg-deb /usr/local/sbin/dpkg-deb \
        && apt-get update \
        && apt-get install wget make g++ pkg-config rustc qtbase5-dev libzmq3-dev condure zurl -y \
        && wget https://docker-is.s3.ap-south-1.amazonaws.com/pushpin.tar.gz \
        && tar -xzvf pushpin.tar.gz \
        && rm -r pushpin.tar.gz \
        && cd pushpin \
        && ./configure && make \
        && apt-get remove make g++ pkg-config rustc qtbase5-dev libzmq3-dev -y \
        && apt-get autoremove --purge -y
WORKDIR /home/pushpin
CMD ["./pushpin"]


# sudo docker buildx build -t internshala/less:1.0.0 -t internshala/less:latest --platform linux/amd64,linux/arm64/v8 -f less.Dockerfile . --push