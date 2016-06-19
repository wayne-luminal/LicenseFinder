#!/usr/bin/env python

import json
import re
from pip._vendor import pkg_resources
from pip._vendor.six import print_
import sys

first_match_regex = re.compile(r'^[\w\-]+: .+')
kv_regex = re.compile(r'(?<=\n)[\w\-]+: .+')

def spec_from_dist_metadata(dist):
    spec = {
        'classifiers': [],
    }

    if dist.has_metadata('METADATA'):
        metadata = dist.get_metadata('METADATA')
        first = first_match_regex.match(metadata)
        result = kv_regex.findall(metadata)

        if first is not None:
            result.append(first.group())

        for res in result:
            parts = res.partition(':')
            k = parts[0].lower().strip()
            v = parts[2].strip()
            if k == 'classifier':
                spec['classifiers'].append(v)
            else:
                spec[k] = v

    return spec


name = sys.argv[1]
dist = pkg_resources.working_set.by_key.get(name.lower())
spec = spec_from_dist_metadata(dist)

print_(json.dumps(spec))
