# cs4450-final-project

# What is this?

This project is a toy parser for python3. It has very limited support for python3 features, and should by no means be considered complete.

## Team Members

- Nelson Earle

## Prerequisites

This repository requires that ANTLR4 is installed. The build script described in the build section below will run ANTLR, assuming that a specific version is installed at a specific location. You will most likely have to edit this script to make sure it works for your system. If you are windows, you should create an equivalent `.bat` script.

## Setup

It is recommended that this repository is run in a virtual environment.

First, follow the usual steps for creating an environment with venv ([see venv docs](https://docs.python.org/3/library/venv.html)).

Make sure you activate the venv:

    . <path-to-venv>/bin/activate

At this point, I usually like to make sure pip is up to date:

    pip3 install --upgrade pip

Then, install the dependencies:

    pip3 install -r requirements.txt

Now, the python environment is all set! Be sure to always activate the venv before running [`main.py`](./main.py).

## Build

A build script is provided for convenience that will run ANTLR to generate the lexer and parser classes on which [`main.py`](./main.py) relies. You should run `./build.sh` after the initial setup, and after any change is made to [`MyPy.g4`](./MyPy.g4).

## How to run

After following all steps listed above, to run the script with the provided test file:

    ./main.py python_test_code.py

This will spit out a tree representation of the parsed code.
