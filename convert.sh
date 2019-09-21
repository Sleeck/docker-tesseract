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

