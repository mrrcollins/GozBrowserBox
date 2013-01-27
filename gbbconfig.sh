#!/bin/sh

git pull /etc/gbb
puppet apply /etc/gbb/puppet/gbb.pp

