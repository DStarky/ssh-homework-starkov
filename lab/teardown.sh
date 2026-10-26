#!/bin/bash
docker rm -f client server 2>/dev/null
docker network rm lab-net 2>/dev/null
