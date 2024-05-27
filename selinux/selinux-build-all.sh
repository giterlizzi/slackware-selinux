#!/bin/sh

# Copyright 2012  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Copyright 2023-2024 Giuseppe Di Terlizzi <giuseppe.diterlizzi@gmail.com>
# All rights reserved.
#
# Based on the xfce-build-all.sh script by Patrick J. Volkerding
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

cd $(dirname $0) ; CWD=$(pwd)

# Set to 1 if you'd like to install/upgrade package as they are built.
# This is recommended.
INST=${INST:-1}

TMP=${TMP:-/tmp}

# Package           | Slackware category
# ------------------|-------------------
# libsepol          | l
# libselinux        | l
# secilc            | ap
# checkpolicy       | ap
# libsemanage       | l
# semodule-utils    | ap
# policycoreutils   | ap
# setools           | ap (?)
# selinux-dbus      | l  (?)
# selinux-python    | l -or- ap (?)
# selinux-gui       | ap
# selinux-sandbox   | ap
# mcstrans          | ap (?)
# restorecond       | ap (?)
# selinux-policy    | l

for dir in \
  libsepol \
  libselinux \
  secilc \
  checkpolicy \
  libsemanage \
  semodule-utils \
  policycoreutils \
  setools \
  selinux-dbus \
  selinux-python \
  selinux-gui \
  selinux-sandbox \
  mcstrans \
  restorecond \
  selinux-policy \
  ; do

  ( cd $dir || exit 1

    package=$(basename $dir)

    if [ ! -e slack-desc ]; then
      touch /tmp/${package}.missing-slack-desc
    fi

    TMP=$TMP \
    ./${package}.SlackBuild || ( touch /tmp/${package}.failed ; exit 1 ) || exit 1

    if [ "$INST" = "1" ]; then
      PACKAGE="$(ls -t $TMP/${package}-*txz | head -n 1)"
      if [ -f $PACKAGE ]; then
        upgradepkg --install-new --reinstall $PACKAGE
      else
        echo "Error:  package to upgrade "$PACKAGE" not found in $TMP"
        exit 1
      fi
    fi

  ) || exit 1

done
