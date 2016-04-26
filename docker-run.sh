#!/bin/bash

docker built -t api .
docker run -itP -v $(pwd):/app api