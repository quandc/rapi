#!/usr/bin/env bash

echo "Starting elasticsearch"
exec elasticsearch -Des.network.host=0.0.0.0 -Des.insecure.allow.root=true
