#!/bin/bash

sudo docker run -it --name script-tester -v $(pwd)/scripts:/stage/scripts/ o12c-scripts-tester
