#!/bin/bash

bar=" ▂▃▄▅▆▇█"
dict="s/;//g;"

# Create a "dictionary" to replace numbers with the bar characters
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# Run cava and pipe output through sed to replace numbers with bars
cava -p ~/.config/cava/waybar.conf | sed -u "$dict"
