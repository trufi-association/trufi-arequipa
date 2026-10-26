#!/bin/bash

if [ -w "./data/Graph.obj" ]; then
    #build and save Graph.obj
    echo "loading Graph.obj"
    java -Xmx2G -jar otp-1.5.0-shaded.jar --autoReload --autoScan --basePath ./data --graphs ./data --server
else
    #load Graph and serve
    echo "building Graph.obj"
    java -Xmx2G -jar otp-1.5.0-shaded.jar --build ./data --preFlight
fi
