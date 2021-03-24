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


Cronjob for updating talkgroups
============================
You can use the included file as a template for setting your update times.  These are suggested and you should not set them to update more than once or twice per day.

Contact
=======
Feel free to contact the author via email: nessenj[@]jimsoffice.org
