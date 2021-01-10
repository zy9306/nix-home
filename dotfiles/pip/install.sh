#!/usr/bin/env bash

rm -rf $HOME/.pip && mkdir -p $HOME/.pip

ln -s $PWD/pip.conf $HOME/.pip/pip.conf
