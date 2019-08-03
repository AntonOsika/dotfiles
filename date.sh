#!/bin/bash
# pipes the date to clipboard
echo $(date +%Y-%m-%d) | xsel -ib

