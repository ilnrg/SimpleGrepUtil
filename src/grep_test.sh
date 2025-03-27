#!/bin/bash

function start_pos() {
    TEST_NAME=""
    FLAG=""
    PATTERN=""
    FILE=""
    TEST_CASE=""
}

function run_utils() {
    $TEST_CASE > grep.txt
    ./simple_$TEST_CASE > simple_grep.txt
}

function compare_results() {
    DIFF="$(LANG=en_US diff -s grep.txt simple_grep.txt)"
    
    if [ "$DIFF" == "Files grep.txt and simple_grep.txt are identical" ]
        then
          echo "✅TEST $TEST_NAME: SUCCESS ✅"
          (( COUNTER_SUCCESS++ ))
        else
          echo "❌TEST $TEST_NAME: FAIL ❌"
          (( COUNTER_FAIL++ ))
    fi
}

function run_test_case() {
    run_utils
    compare_results
}

echo "TEST START"
echo "________________________________________"
echo "JUST GREP"
    start_pos
    TEST_NAME="1 - GREP"
    FLAG=""
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="2 - GREP WITH 2 FILES"
    FLAG=""
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="3 - GREP WITH 3 FILES"
    FLAG=""
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt test_files/test2.txt"
    TEST_CASE="grep $PATTERN $FILE"
    run_test_case
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "________________________________________"
echo "1 FLAG"
    start_pos
    TEST_NAME="4 - FLAG -E"
    FLAG="-e"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="5 - FLAG -I"
    FLAG="-i"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="6 - FLAG -V"
    FLAG="-v"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="7 - FLAG -C"
    FLAG="-c"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="8 - FLAG -L"
    FLAG="-l"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="9 - FLAG -N"
    FLAG="-n"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="10 - FLAG -H"
    FLAG="-h"
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="11 - FLAG -S"
    FLAG="-s"
    PATTERN="test"
    FILE="tet.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="12 - FLAG -F"
    FLAG="-f"
    PATTERN="test_files/f.txt"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="13 - FLAG -O"
    FLAG="-o"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "________________________________________"
echo "2 FLAGS"
    start_pos
    TEST_NAME="14 - FLAGS -E & -E"
    FLAG="-e"
    PATTERN="test"
    PATTERN2="123"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FLAG $PATTERN2 $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="15 - FLAGS -E & -I"
    FLAG="-ie"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="16 - FLAGS -E & -V"
    FLAG="-ve"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="17 - FLAGS -E & -C"
    FLAG="-ce"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="18 - FLAGS -E & -L"
    FLAG="-le"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="19 - FLAGS -E & -N"
    FLAG="-ne"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="20 - FLAGS -E & -H"
    FLAG="-he"
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="21 - FLAGS -E & -F"
    FLAG="-e"
    PATTERN="test"
    FLAG2="-f"
    PATTERN2="test_files/f.txt"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FLAG2 $PATTERN2 $FILE"
    run_test_case

    start_pos
    TEST_NAME="22 - FLAGS -E & -O"
    FLAG="-oe"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="23 - FLAGS -I & -V"
    FLAG="-iv"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="24 - FLAGS -I & -C"
    FLAG="-ic"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="25 - FLAGS -I & -L"
    FLAG="-il"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="26 - FLAGS -I & -N"
    FLAG="-in"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="27 - FLAGS -I & -H"
    FLAG="-ih"
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="28 - FLAGS -I & -F"
    FLAG="-if"
    PATTERN="test_files/f.txt"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="29 - FLAGS -I & -O"
    FLAG="-io"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="30 - FLAGS -V & -C"
    FLAG="-vc"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="31 - FLAGS -V & -L"
    FLAG="-vl"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="32 - FLAGS -V & -N"
    FLAG="-vn"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="33 - FLAGS -V & -H"
    FLAG="-vh"
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="34 - FLAGS -V & -F"
    FLAG="-vf"
    PATTERN="test_files/f.txt"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="35 - FLAGS -V & -O"
    FLAG="-vo"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="36 - FLAGS -C & -L"
    FLAG="-cl"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="37 - FLAGS -C & -N"
    FLAG="-cn"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="38 - FLAGS -C & -H"
    FLAG="-ch"
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="39 - FLAGS -C & -F"
    FLAG="-cf"
    PATTERN="test_files/f.txt"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="40 - FLAGS -C & -O"
    FLAG="-co"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="41 - FLAGS -L & -N"
    FLAG="-ln"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="42 - FLAGS -L & -H"
    FLAG="-lh"
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="43 - FLAGS -L & -F"
    FLAG="-lf"
    PATTERN="test_files/f.txt"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="44 - FLAGS -L & -O"
    FLAG="-lo"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
    
    start_pos
    TEST_NAME="45 - FLAGS -N & -H"
    FLAG="-nh"
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="46 - FLAGS -N & -F"
    FLAG="-nf"
    PATTERN="test_files/f.txt"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="47 - FLAGS -N & -O"
    FLAG="-no"
    PATTERN="test"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="48 - FLAGS -H & -F"
    FLAG="-hf"
    PATTERN="test_files/f.txt"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="49 - FLAGS -H & -O"
    FLAG="-ho"
    PATTERN="test"
    FILE="test_files/test.txt test_files/test1.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case

    start_pos
    TEST_NAME="50 - FLAGS -F & -O"
    FLAG="-of"
    PATTERN="test_files/f.txt"
    FILE="test_files/test.txt"
    TEST_CASE="grep $FLAG $PATTERN $FILE"
    run_test_case
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
if [ $COUNTER_SUCCESS > 0 ]
    then
        echo "✅SUCCESS: $COUNTER_SUCCESS/50"
    else
        echo "✅SUCCESS: 0/50"
fi

if [ $COUNTER_FAIL > 0 ]
    then
        echo "❌FAIL: $COUNTER_FAIL/50"
    else
        echo "❌FAIL: 0/50"
fi
