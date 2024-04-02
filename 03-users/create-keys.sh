#!/usr/bin/env bash

test -n "$DEBUG" && set -x

#                      __ __       ___
#                     /\ \\ \    /'___`\
#                     \ \ \\ \  /\_\ /\ \
#                      \ \ \\ \_\/_/// /__
#                       \ \__ ,__\ // /_\ \
#                        \/_/\_\_//\______/
#                           \/_/  \/_____/
#                                         Algoritimos
#
#
#      Author: Ivan Lopes
#        Mail: ivan@42algoritmos.com.br
#        Site: http://www.42algoritmos.com.br
#     License: gpl
#       Phone: +1 561 801 7985
#    Language: Shell Script
#        File: create-keys.sh
#        Date: qua 30 ago 2017 00:18:31 -03
# Description:
# ----------------------------------------------------------------------------
# Modo strict
set -euo pipefail
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################

GN=slocal
# ----------------------------------------------------------------------------
# Run!
for u in "$@"; do
  ssh-keygen -q -t rsa -f id_rsa_$u -N ""
  user=$u

  echo echo =============================================================
  group=$user
  echo '#'$user
  #echo sudo groupadd ${group}
  #echo sudo useradd -d /home/${user} -ms /bin/bash -g root -G sudo -p ${group} ${user}
  echo sudo adduser --gecos \'Short description of $user\' --disabled-password ${user}
  echo sudo usermod -a -G sudo ${user}
  echo echo \"${user} ALL=\(ALL\) NOPASSWD:ALL\" \| sudo tee -a /etc/sudoers
  echo sudo mkdir /home/$user/.ssh
  echo sudo cp id_rsa_$u.pub /home/$user/.ssh/authorized_keys
  echo sudo usermod -aG docker $user
  echo sudo chown $user:${group} -R /home/$user/.ssh
  echo echo =============================================================
  echo
  echo
  echo
  echo
  echo echo =============================================================
  echo '#' xauth with complain unless ~/.Xauthority exists
  echo touch ~/.Xauthority
  echo xauth generate :0 . trusted
  echo xauth add \${HOST}:0 . \$\(xxd -l 16 -p /dev/urandom\)
  echo echo =============================================================
  echo
  echo
  echo
  echo
  echo
  echo echo =============================================================
  group=$GN
  echo '#' Create a user without login
  echo sudo groupadd ${group}
  echo sudo useradd -g ${group} -d /opt/${user} -s /bin/false ${user}
  echo sudo usermod -G ${group} ${user}
  echo sudo mkdir /opt/${user}
  echo sudo touch /opt/${user}/${user}-server-log
  echo sudo touch /opt/${user}/${user}-server-errors
  echo sudo chown -R ${user}:${group} /opt/${user}
  echo echo =============================================================
  echo
  echo
  echo echo =============================================================
  app=$user
  echo sudo addapp --gecos \'${app^} Short description\' --disabled-password --home /opt/${app} ${app}
  echo echo =============================================================
  echo
  echo

done
# ----------------------------------------------------------------------------
exit 0
