Built with Go version go1.1.2

To build:

    export GOPATH=[...]/git/epaxos/

    go install master
    go install server
    go install client

To run:

    bin/master &
    bin/server -port 7070 &
    bin/server -port 7071 &
    bin/server -port 7072 &
    bin/client

# Command Line Arguments

## Client (`client.go`)
- `-maddr`: Master address (default: "localhost").
- `-mport`: Master port (default: 7087).
- `-q`: Total number of requests (default: 5000).
- `-w`: Percentage of updates/writes (0-100; default: 100).
- `-e`: Egalitarian/no-leader mode (default: false).
- `-f`: Fast Paxos mode; send directly to all replicas (default: false).
- `-r`: Number of sequential rounds to split requests into (default: 1).
- `-p`: GOMAXPROCS setting (default: 2).
- `-check`: Verify every expected reply is received exactly once (default: false).
- `-eps`: Extra messages per round to send (overheads for stragglers; default: 0).
- `-c`: Conflict percentage. `-1` uses Zipfian distribution; `0-100` uses Uniform (default: -1).
- `-s`: Zipfian `s` parameter (default: 2).
- `-v`: Zipfian `v` parameter (default: 1).

## Master (`master.go`)
- `-port`: Port to listen on (default: 7087).
- `-N`: Number of replicas to expect (default: 3).

## Server (`server.go`)
- `-port`: Port to listen on (default: 7070).
- `-maddr`: Master address (default: "localhost").
- `-mport`: Master port (default: 7087).
- `-addr`: Address of this server instance (default: "localhost").
- `-m`: Use Mencius replication (default: false).
- `-g`: Use Generalized Paxos replication (default: false).
- `-e`: Use EPaxos replication (default: false).
    - *Note: If `-m`, `-g`, and `-e` are false, Classic Paxos is used.*
- `-p`: GOMAXPROCS setting (default: 2).
- `-cpuprofile`: File path to write CPU profile (default: disabled).
- `-thrifty`: Optimization to use minimum required messages (default: false).
- `-exec`: Execute commands (default: false).
- `-dreply`: Reply to client only after command execution (default: false).
- `-beacon`: Enable beacons to measure relative replica speeds (default: false).
- `-durable`: Log to stable store/file (default: false).