#!/usr/bin/env python

# Src: http://www.cs.cmu.edu/~benhdj/Mac/unix.html#getIP

import urllib, re, sys, os

# if this changes we need to revise the code to get the external IP
ip_telling_url = 'http://www.dyndns.org/cgi-bin/check_ip.cgi'

if len(sys.argv) == 1:
  # get the external IP
  mo = re.search(r'\d+\.\d+\.\d+\.\d+', urllib.urlopen(ip_telling_url).read())
  if mo:
    print mo.group()
  else:
    print 'Cannot get the external IP!'
else:
  # get the internal IP of an interface
  targetInt = sys.argv[1]
  output = os.popen('ipconfig getifaddr %s 2>&1' % targetInt).read().strip()
  if re.match(r'\d+\.\d+\.\d+\.\d+', output):
    print output
  else:
    print 'Cannot get the internal IP for interface \'%s\'' % targetInt
