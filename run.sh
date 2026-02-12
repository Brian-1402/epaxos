#!/bin/bash

rm -rf logs
mkdir -p logs

echo "Starting Master..."
./bin/master -port 7087 -N 3 > logs/master.log 2>&1 &

echo "Starting Servers..."
bin/server -port 7070 -e -exec -dreply > logs/server-1.log 2>&1 &
bin/server -port 7071 -e -exec -dreply > logs/server-2.log 2>&1 &
bin/server -port 7072 -e -exec -dreply > logs/server-3.log 2>&1 &

echo "Waiting for servers to initialize..."

# Check: Loop until we see "Done connecting to peers" 3 times across all logs
# We use 2>/dev/null to hide errors if the log files haven't been created yet
while [ $(grep -h "Done connecting to peers" logs/*.log 2>/dev/null | wc -l) -lt 3 ]; do
    sleep 0.5
done

echo "All servers ready! Starting Client..."

# 3. Run Client
bin/client -e \
    -q 500 \
    -r 3 \
    -w 90 \
    -c 50 \
    # -check \