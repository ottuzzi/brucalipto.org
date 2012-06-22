#!/bin/sh
tar cjf - public | ssh piero@vps.brucalipto.org "rm -rf public;tar xvjf -"
