#!/bin/bash

# Activate the virtual environment
source myenv/bin/activate

sudo apt install python-pip
sudo apt-get install python-pip

# Ensure pip is installed and upgrade it
python -m ensurepip --upgrade
pip install --upgrade pip

# Install required packages
pip install firebase_admin
pip install flask

# Run the server
python3 server.py
