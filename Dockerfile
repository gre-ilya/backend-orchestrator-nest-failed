FROM node:18.15.0-slim

# ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait /wait
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*
COPY ./wait /wait
RUN chmod +x /wait

WORKDIR /workdir
 
# COPY package*.json /workdir/
# 
# RUN npm install
# 
# COPY . .
