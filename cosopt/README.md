# COSOPT Analysis

## Prerequisites

### [COSOPT Assembly Line](https://github.com/mfcovington/COSOPT-Assembly-Line)

The [COSOPT Assembly Line](https://github.com/mfcovington/COSOPT-Assembly-Line) does the following:

- Converts expression data into properly formatted COSOPT input files
- Runs COSOPT
- Converts COSOPT output into a more user-friendly format for downstream analyses


The expression data format should be a tab-delimited file with rows of genes and columns of timepoints. The first column of the header should be `Gene` and the other columns should be the hour of the timepoint. For example:

    Gene    0   0   0   2   2   2   4   4   4   ...
    HanXRQChr00c0001g0570931    0.392789742 1.94947307  0.392844263 0.119232486 0.871761678 0.386793079 0.104358883 0.313879796 0.843140736 ...
    HanXRQChr00c0003g0570971    0.130929914 0   0.196422132 0   0.10897021  0.128931026 0.208717765 0.313879796 0.389141878 ...
    HanXRQChr00c0003g0570981    0.261859828 0.243684134 0.982110658 0.476929945 0.217940419 0.515724106 0.417435531 0.78469949  0.583712817 ...
    HanXRQChr00c0004g0571001    6.5464957   5.361050941 4.91055329  5.961624309 4.467778599 4.254723872 3.861278659 6.591475715 6.226270047 ...


### [Wine](https://www.winehq.org)

Although COSOPT was written to run on Microsoft Windows, COSOPT Assembly Line uses [Wine](https://www.winehq.org) to run COSOPT on other operating systems, including OS X and Linux.


## Running COSOPT Assembly Line

For reproducibility, I typically `source` a file that has a group of variables set and runs the COSOPT Assembly Line using these variables. For example, this experiment was analyzed by running the following on the command line:

```sh
source east.2019-01.sh > east.log 2> east.err
source west.2019-01.sh > west.log 2> west.err
source merged.2019-01.sh > merged.log 2> merged.err
```


The file for the East analysis (`east.2019-01.sh`) looks like this:

```sh
# SET THE SIDE BEING ANALYZED
SIDE=East

# SET THESE ACCORDING TO YOUR FILE LOCATIONS
BASE_DIR=<Path to Base Directory of Analysis>
BIN_DIR=<Path to COSOPT-Assembly-Line/bin/>

# CHANGE THESE IF NECESSARY
OUT_DIR=$BASE_DIR/output-files/$SIDE-session
COUNT_FILE_IN=$BASE_DIR/input-files/HA2015_HanXRQr1.0-$SIDE-COSOPT.txt
COSOPT_OUT_FILE=$BASE_DIR/output-files/HA2015_HanXRQr1.0-$SIDE.cosopt-results.tsv

# DO NOT ALTER BELOW THIS LINE
$BIN_DIR/cosopt-formatter.pl -o $OUT_DIR $COUNT_FILE_IN
cd $OUT_DIR
wine cmd /c doit.bat > cosopt.log 2> cosopt.err
$BIN_DIR/cosopt-deformatter.pl session.op4 $COSOPT_OUT_FILE
```


Leave the last 4 lines alone when analyzing a different experiment, but be sure that the other variables are set correctly.


<!-- INCLUDE NOTE ABOUT LINE ENDINGS!!! -->
