#!/bin/bash

<<PROGRAM_TEXT

This script will rebuild an archive of /var/www/larryforalaska resources
 if any of the resources have been changed or added.

The archive is extracted on a new instance with:

tar -xvzf /mnt/efs/aws-lam1-ubuntu/larryforalaska.tgz --directory /var/www

The following will list files changed since the archive was last rebuilt:

if [ $(find /var/www/larryforalaska -newer /mnt/efs/aws-lam1-ubuntu/larryforalaska.tgz -print \
 | sed 's|^/var/www/larryforalaska/||' | grep -v '.git/' | grep -v '.git$' | wc -l) \
 -gt 0 ]
then
  find /var/www/larryforalaska -newer /mnt/efs/aws-lam1-ubuntu/larryforalaska.tgz \
  | grep -v '.git/' | grep -v '.git$' \
  | xargs ls -ld --time-style=long-iso  | sed 's|/var/www/larryforalaska/||' 
fi

PROGRAM_TEXT

if [ $(find /var/www/larryforalaska -newer /mnt/efs/aws-lam1-ubuntu/larryforalaska.tgz -print \
| sed 's|^/var/www/larryforalaska/||' | grep -v '.git/' \
| grep -v '.git$' | wc -l) -gt 0 ]; then

  echo Recreating the aws-lam1-ubuntu/larryforalaska.tgz archive

  rm -f /mnt/efs/aws-lam1-ubuntu/larryforalaska.t{gz,xt}

  tar -cvzf /mnt/efs/aws-lam1-ubuntu/larryforalaska.tgz \
  --exclude='larryforalaska/.git' \
  --exclude='RCS' \
  --directory /var/www larryforalaska 2>&1 \
  | tee /mnt/efs/aws-lam1-ubuntu/larryforalaska.txt

fi
