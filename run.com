#!/bin/bash
rm nohup.out -f
matlab="matlab"
export MLM_LICENSE_FILE=/usr/local/MATLAB/R2013b/licenses/network.lic
export MLM_LICENSE_FILE=27000@lmas.engr.washington.edu,27000@nexus.engr.washington.edu,27000@persephone.engr.washington.edu
nohup nice matlab -noFigureWindows -nosplash -nodesktop << eof1
MAIN
exit
eof1
echo 'done'
echo ''
cat nohup.out | grep -v "exclude an item from Time Machine"
echo ''
echo 'the above output can be found in nohup.out'
