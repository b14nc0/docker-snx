#!/bin/bash
server=$SNX_SERVER
user=$SNX_USER
password=`echo $SNX_PASSWORD | base64 -d`


/usr/bin/expect <<EOF
set timeout 10
log_user 0
send_user "Disconnecting old sessions...\n"
spawn snx -d
expect {
        eof {
               sleep 1
               send_user "Connecting to VPN...\n"
               spawn -ignore HUP /bin/sh -c "snx -s $server -u $user"
               expect {
                       "password:" {
                                      send "$password\r"
                                      expect {
                                              "Do you accept" {
                                                               send_user "Accepting certificate\n"
                                                               send "y\r"
                                                               exp_continue
                                              }
                                              "connected." {
                                                            send_user "Connected!\n"
                                                            exit 0
                                              }
                                              "Connection aborted." {
                                                                     send_user "Connection aborted.\n"
                                                                     exit 0
                                              }
                                              "Authentication failed" {
                                                                       send_user "Auth failed.\n"
                                                                       exit 0
                                              }
                                              eof {
                                                   send_user "Error!\n"
                                                   exit 0
                                              }
                                              timeout {
                                                       send_user "Timeout!\n"
                                                       exit 0
                                              }
                                      }
                                   }
                      eof {
                           send_user "Error!\n"
                           exit 0
                      }
                      timeout {
                               send_user "Timeout!\n"
                               exit 0
                      }
              }
       }
}
expect eof
}
EOF

/bin/bash
