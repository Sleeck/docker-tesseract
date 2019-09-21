#!/bin/bash

filename=$(basename -- "$1")
extension="${filename##*.}"
if [ -z "$TESSERACT_LANGUAGE" ]
then
	echo '$TESSERACT_LANGUAGE empty. Falling back to english language'
	TESSERACT_LANGUAGE=eng
fi

if [ "$extension" == "jpg" ]
then
    tesseract $1 ./$(basename $1 .jpg) -l $TESSERACT_LANGUAGE pdf
fi

if [ ! -z "$TESSERACT_OUTPUT_USER_GROUP" ]
then
    chown $TESSERACT_OUTPUT_USER_GROUP ./$(basename $1 .jpg).pdf
fi
