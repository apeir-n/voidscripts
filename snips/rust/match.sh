#!/bin/sh

printf "match thing {\n"
printf "    1 => return 0,\n"
printf "    2 => return 0,\n"
printf "    3 => return 0,\n"
printf "    _ => return 1,\n"
printf "}"
