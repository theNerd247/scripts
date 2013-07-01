#!/bin/bash

##############################
# pbar
#
# author: Noah Harvey
# version: 0.0.5
# 
# ctrl interface for pianobar
##############################

CONFIGDIR=$HOME/.config/pianobar
LOGFILE=$CONFIGDIR/log.txt
CMD=0

usage()
{
	echo '
    usage: pbar [@OPTIONS, @COMMAND]

      pbar is a terminal based interface to pianobar. 

      NOTE: command-line arguments are processed in any order. 
            For instance, "pbar -l p" , "pbar p -l" and "pbar -l p --log" are all valid commands

      COMMAND: 
        command to send pianobar as if you were using pianobar without pbar ('+','p',etc...)

      OPTIONS: 

        -h, --h, --help
          print out pbar help

        -l --log 
          print out pianobar log'
}

#send command to pianobar
sendCMD()
{
	cmd=$1
	#BUG: figure out how to pass the newline char to allow change of station
	echo -ne $1 > $CONFIGDIR/ctl
}

#start up pianobar if it isn't running
start()
{
	echo '' > $LOGFILE
	echo "starting pianobar"
	echo $CMD | pianobar >> $LOGFILE &
}

getRUNNING()
{
	RUNNING=$(pstree | grep -i pianobar)
}

quit()
{
	sendCMD q 
	echo -n '' > $CONFIGDIR/ctl
	getRUNNING
	if [[ ! RUNNING ]] ; then
		exit
	else
		killall pianobar
	fi	
}

#parse args
for arg in $@
do 
	case $arg	in
		-h | --help)
			usage
			exit
			;;
		-l | --log)
			cat $LOGFILE
			exit
			;;
		-q | --quit)
			echo "stopping pianobar"
			quit
			exit
			;;
		*)
			CMD=$arg
	esac
done

getRUNNING
if [[ ! $RUNNING ]] ; then
	start
	exit	
fi

#send the command to pianobar
sendCMD $CMD
cat $LOGFILE
echo '\n'
