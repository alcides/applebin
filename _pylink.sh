#!/bin/bash

# Author: Eric  Florenzano
# http://www.eflorenzano.com/blog/post/first-two-django-screencasts/

ln -s `pwd`/$1 `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`/$1