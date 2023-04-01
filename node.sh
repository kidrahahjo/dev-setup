#!/bin/bash

# Install latest version of Node.JS. This will install the stated Node.js version and NPM
# See Node.js distribution information: https://github.com/nodesource/distributions/blob/master/README.md
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs

