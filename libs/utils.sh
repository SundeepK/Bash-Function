#!/bin/bash

#generic error function
function exit_on_error
{
  ERROR_MSG="${1:-Error occured while running script}"
  echo "$ERROR_MSG" 1>&2
  exit 1
}