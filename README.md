# FreeDMR-Scripts
Scripts for use with HBMonv2 on FreeDMR
=======================================

About
=====
These scripts increase the functionality of downloading updates to the FreeDMR talkgroup lists for various parts of the HBMonv2 dashboard.

These scripts rely on HBMonv2 available from https://github.com/sp2ong/HBMonv2

Required components are
=======================
* HBMonv2 (https://github.com/sp2ong/HBMonv2)


Installation
============
* Copy these scripts to a location on your server.  On both my hotspot and repeater servers, they are located with the dashboard components (/opt/HBMonv2), although they can live wherever you want them to.
* Ensure the path in updateTGIDs.sh is set to the same path where you installed the scripts.
* Add the associated cron entries so they run at scheduled times.


Usage
=====
To use these scripts, simply add the corresponding cron entries, the scripts will do the necessary work to download the data from FreeDMR and restart the dashboard (if necessary).

Features
========


Cronjob for updating DMR IDs
============================
You can use the included script to update the DMR IDs periodically. Copy the files updateDMRIDs to /etc/cron.d/ and updateDMRIDs.sh to /var/www from the cron folder in this repo. The paths may have to be aligned to your system architecture. The Update script will then be executed once every 24 hours at 3:30. For security considerations please make sure that the cron folder is not copied to your web server's www root directory.

Contact
=======
Feel free to contact the author via email: nessenj[@]jimsoffice.org
