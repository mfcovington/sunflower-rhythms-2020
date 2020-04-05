# SET THE SIDE BEING ANALYZED
SIDE=East

# SET THESE ACCORDING TO YOUR FILE LOCATIONS
BASE_DIR=    # Path to Base Directory of Analysis
BIN_DIR=     # Path to COSOPT-Assembly-Line/bin/

# CHANGE THESE IF NECESSARY
OUT_DIR=$BASE_DIR/output-files/$SIDE-session
COUNT_FILE_IN=$BASE_DIR/input-files/HA2015_HanXRQr1.0-$SIDE-COSOPT.txt
COSOPT_OUT_FILE=$BASE_DIR/output-files/HA2015_HanXRQr1.0-$SIDE.cosopt-results.tsv

# DO NOT ALTER BELOW THIS LINE
$BIN_DIR/cosopt-formatter.pl -o $OUT_DIR $COUNT_FILE_IN
cd $OUT_DIR
wine cmd /c doit.bat > cosopt.log 2> cosopt.err
$BIN_DIR/cosopt-deformatter.pl session.op4 $COSOPT_OUT_FILE
