#!/bin/bash -eux

cp -i "${OACIS_ROOT}/Gemfile.lock" .
bundle install
bundle exec iruby register --force
jupyter kernelspec install ~/.ipython/kernels/ruby

