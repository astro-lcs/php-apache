#!/usr/bin/expect -f
spawn pecl install event
expect "Enable internal debugging in Event"
send "no\r"
expect "Enable sockets support in Event"
send "yes\r"
expect "libevent installation prefix"
send "/usr\r"
expect "Include libevent's pthreads library and enable thread safety support in Event"
send "no\r"
expect "Include libevent protocol-specific functionality support including HTTP, DNS, and RPC"
send "yes\r"
expect "Include libevent OpenSSL support"
send "no\r"
expect "PHP Namespace for all Event classes"
send "yes\r"
expect "openssl installation prefix"
send "no\r"
expect eof
