#!/bin/bash

docker build -t api .
docker run -itP -p 3000:3000 -v $(pwd):/app api