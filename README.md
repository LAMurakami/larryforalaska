# Larry for Alaska - Larry Murakami for Alaska

[larryforalaska.lam1.us](http://larryforalaska.lam1.us/)
[larryforalaska.lamurakami.com](http://larryforalaska.lamurakami.com/)

This repo contains content in the html folder and an apache2 configuration
that can be implemented with:

 sudo ln -s /var/www/larryforalaska/larryforalaska_apache2.conf \
 /etc/apache2/sites-available/060_larryforalaska.conf

 sudo a2ensite 060_larryforalaska
 sudo systemctl reload apache2

If the repo contents are installed in a location other than /var/www
the path in the configuration and in the instuctions would have to be modified.

The larryforalaska_archive_rebuild.bash script will Rebuild an archive of /var/www/larryforalaska
resources when they change.  It is intended to be run daily with:

 ln -s /var/www/larryforalaska/larryforalaska_archive_rebuild.bash /mnt/efs/aws-lam1-ubuntu/larryforalaska

This would then be picked up by the Daily cron job to backup
/mnt/efs/aws-lam1-ubuntu archives.

 $ cat /etc/cron.daily/Bk-20-aws-changes
 #!/bin/bash
 run-parts --report /mnt/efs/aws-lam1-ubuntu
 [19:34:30 Sunday 06/14/2020] ubuntu@aws
