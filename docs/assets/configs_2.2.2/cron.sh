#!/bin/bash

source $HOME/elena2_venv/bin/activate
export ELENA_HOME=$HOME/local_data

elena > $HOME/last.log 2>$HOME/last_error.log