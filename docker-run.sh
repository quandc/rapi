#!/bin/bash

docker build -t api .
docker run -itP -v $(pwd):/app api