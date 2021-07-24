uptime -p | awk '{print "Time "; print $2; print $4}' | tr '\n' '-' | rev | cut -c 2- | rev
