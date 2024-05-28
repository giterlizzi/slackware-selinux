# SELinux for Slackware

These are the hackings on SELinux integreation to Slackware Linux.
To date it has just keep up with the -current development branch. 

## About SELinux

SELinux is a security enhancement to Linux which allows users and administrators more control over access control.

Access can be constrained on such variables as which users and applications can access which resources. These resources may take the form of files. Standard Linux access controls, such as file modes (-rwxr-xr-x) are modifiable by the user and the applications which the user runs. Conversely, SELinux access controls are determined by a policy loaded on the system which may not be changed by careless users or misbehaving applications.

SELinux also adds finer granularity to access controls. Instead of only being able to specify who can read, write or execute a file, for example, SELinux lets you specify who can unlink, append only, move a file and so on. SELinux allows you to specify access to many resources other than files as well, such as network resources and interprocess communication (IPC). 

## Instruction

Build and install/upgrade all SELinux packages:

*NOTE* `audit` package is required for build SELinux.

    cd selinux
    sh selinux-build-all.sh

## TODO

* Optimize `selinux-policy` for Slackware Linux
* Add all dependencies:
  * `audit`
  * ...
* Move all SELinux packages in Slackware categories (`a`, `ap`, `l`, etc.)
* Rebuild some Slackware-core packages for SELinux
  * `a/coreutils`
  * `a/pam`
  * `a/shadow`
  * `a/sysvinit`
  * `ap/sudo`
  * `n/iproute2`
  * `n/net-tools`

## Copyright

 - Copyright 2023-2024 © Giuseppe Di Terlizzi
 - Slackware® is a Registered Trademark of Patrick Volkerding
 - Linux is a Registered Trademark of Linus Torvalds
