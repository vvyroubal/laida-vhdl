FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ghdl \
    python3 \
    python3-pip \
    python3-matplotlib \
    make \
    && pip3 install vcdvcd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
