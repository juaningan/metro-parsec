#!/usr/bin/wish -f
#
option add *font "-bitstream-swiss*742-medium-r-normal--19-140-85-85-p-110-hp-roman8"
wm overrideredirect . 1
wm geometry . 81x22+875+968
button .btn1 -text " ATS " -command {exec /usr/local/metro/ats/firefox_wrapper.sh &}

pack .btn1

after 1000 sube
proc sube {} {
        after 10000 sube
        raise .
}
