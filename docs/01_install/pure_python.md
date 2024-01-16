# Pure Python 

!!! note "Note:" 
    This is a work in progress

## Pre requisites

The pure-python install assumes that you are working on a linux machine running Debian 12 (bookworm) or similar Raspberry Pi OS using Python 3.11

## Modules installation

Install the modules on a new virtual environment.

The modules are:

- elena: main trading lib.
- elena-basics: basic strategies _ready to use_.
- elena-notifications-telegram: plugin to send notifications to telegram.

```shell
python3 -m venv elena2_venv
source elena2_venv/bin/activate
pip install -U pip setuptools wheel
pip install git+https://github.com/Pasta-fantasia/elena.git@v2.2.2
pip install git+https://github.com/Pasta-fantasia/elena-basics.git@v0.0.5 
pip install git+https://github.com/Pasta-fantasia/elena-notifications-telegram.git@main
```

## Create a data directory 

```
mkdir $HOME/local_data
```

## Create basic configuration files


## Configure bash environment 
```
echo "source $HOME/elena2_venv/bin/activate" >> $HOME/.bashrc
echo "export ELENA_HOME=$HOME/local_data" >> $HOME/.bashrc
```

## Configure cron