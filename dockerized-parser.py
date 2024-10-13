#!/usr/bin/env python

# not good enough at bash to do this so idea here is to parse the arguments
# and return any additional mount options for docker
# The first argument is the workdir, add that directly

import sys
import os

result = []
for arg in sys.argv[1:]:
    if '=' in arg:
        opt, value = arg.split('=', 1)
        if os.path.isdir(value):
            result.append(value)
        elif os.path.isfile(value):
            result.append(os.path.dirname(value))
    else:
        if os.path.isdir(arg):
            result.append(arg)
        elif os.path.isfile(arg):
            result.append(os.path.dirname(arg))

seen = set()
final = ""
if len(result) > 0:
    final = ""
    for res in set(result):
        mount_str = f' --mount type=bind,source={os.path.abspath(res).rstrip("/")}/.,target={os.path.abspath(res).rstrip("/")}/.'
        if mount_str not in seen:
            final += mount_str
            seen.add(mount_str)
sys.stdout.write(final)
