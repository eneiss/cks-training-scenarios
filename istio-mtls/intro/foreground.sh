echo "Installing scenario..."
# Wait in the background and tail the installation logs at the same time
(while [ ! -f /tmp/toto ]; do sleep 1; done)&
cmdpid=$!
tail -f -n +0 /var/log/killercoda/background0_stdout.log &
wait $cmdpid
kill $!
