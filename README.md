# Jupyter+OACIS integration

OACIS APIs available on Jupyter.

## Quick start

1. Set 'OACIS_ROOT' environment
    - `export OACIS_ROOT=~/oacis`
2. Run the start script
    - `start.sh`
        - This installs iruby and its dependent gems as well as gems used in OACIS.
3. Launch jupyter by `jupyter notebook`
4. Create a new notebook with ruby kernel on the top page of jupyter frontend.
5. In a cell of jupyter, load the environment of OACIS by evaluating the following line.
    - `require File.join(ENV['OACIS_ROOT'], 'config/environment')`

Now Jupyter is ready to use with OACIS!
Try OACIS API, like `Simulator.first`.
