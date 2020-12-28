#!/bin/bash

sudo apt update \
&& sudo apt upgrade -y \
&& sudo apt install -y wget zip unzip pixz curl git \
&& touch ./pylaxz/shells/conf.lxz