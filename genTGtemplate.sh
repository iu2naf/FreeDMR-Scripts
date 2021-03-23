#!/bin/bash

FILE_NAME="/tmp/talkgroups.csv"
FILE_URL="http://downloads.freedmr.uk/downloads/Talkgroups_FreeDMR.csv"

rm /tmp/info_template.html

OLD_MD5=`md5sum /opt/HBMonv2/templates/info_template.html | cut -d' ' -f 1`

wget -O ${FILE_NAME} ${FILE_URL}

cat <<EOF >>/tmp/info_template.html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DMR Server monitor - Info</title>
<script type="text/javascript" src="scripts/hbmon.js"></script>
<link rel="stylesheet" type="text/css" href="css/styles.css" />
<style>
.link {<<<theme_color>>>}
.button { <<<theme_color>>> }
.dropbtn { <<<theme_color>>> }
</style>
<meta name="description" content="Copyright (c) 2016-21.The Regents of the K0USY Group. All rights reserved. Version SP2ONG 2019-2021 (v2021)" />
</head>
<body style="background-color: #d0d0d0;font: 10pt arial, sans-serif;">
<center><div style="width:1250px; text-align: center; margin-top:5px;">
<img alt="" src="/img/logo.png" />
</div>
<div style="width: 1100px;">
<p style="text-align:center;"><span style="color:#000;font-size: 18px; font-weight:bold;"><<<system_name>>></span></p>
<p></p>
</div>
<div style="width: 1100px;">
<noscript>You must enable JavaScript</noscript>
    <p id="info"></p>
</div>
<!-- TG table -->
<div style="width: 1100px; margin-left:0px;">
<fieldset style="box-shadow:0 0 10px #999;background-color:#e0e0e0e0; width:1050px;margin-left:15px;margin-right:15px;font-size:14px;border-top-left-radius: 10px; border-top-right-radius: 10px;border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;">
<legend><b><font color="#000">&nbsp;.: Talk Groups :.&nbsp;</font></b></legend>
<table style="margin-top:5px; table-layout:fixed; font: 10pt arial, sans-serif;background-color: #f9f9f9f9;">
    <tr style=" height: 32px;font: 10pt arial, sans-serif;border:0;<<<theme_color>>>">
        <th style='width: 150px;'>TG#</th>
        <th style='width: 80px;'>TS 1</th>
        <th style='width: 80px;'>TS 2</th>
        <th style='width: 790px;'>Description</th>
    </tr>
EOF

while IFS=$'\t' read -r -a fields; do
	#printf '[%s]\n' "${fields[@]}"

	country="${fields[0]}"
	tgid="${fields[1]}"
	tgn="${fields[2]}"
	tgname="${tgn%\\n}"

	if [[ "${fields[0]}" =~ ^World ]] || [[ "${fields[0]}" =~ ^USA ]]
	then     
	   cat <<EOF >> /tmp/info_template.html
	   <tr>
	   <td>&nbsp;<b>TG ${fields[1]}</b>&nbsp;</td>
	   <td>&nbsp;<b>D</b>&nbsp;</td>
	   <td>&nbsp;<b>D | S</b>&nbsp;</td>
	   <td>&nbsp;<b>$tgname</b>&nbsp;</td>
	   </tr>
EOF
	fi
done < ${FILE_NAME}

cat <<EOF >> /tmp/info_template.html
</table>
<br>
<span style="text-align: center;">Hotspot: D - Duplex | S - Simplex</span>
</fieldset></div><br>

<p style="text-align: center;"><span style="text-align: center;">
Copyright (c) 2016-2021<br>The Regents of the <a href=http://k0usy.mystrikingly.com/>K0USY Group</a>. All rights reserved.<br><a href=https://github.com/sp2ong/HBMonv2>Version SP2ONG 2019-2021</a><br><br></span>
    <!-- THIS COPYRIGHT NOTICE MUST BE DISPLAYED AS A CONDITION OF THE LICENCE GRANT FOR THIS SOFTWARE. ALL DERIVATEIVES WORKS MUST CARRY THIS NOTICE -->
    <!-- This is version of HBMonitor SP2ONG 2019-2021 (v2021) -->
</p>
</center>
</body>
</html>
EOF

NEW_MD5=`md5sum /tmp/info_template.html | cut -d' ' -f 1`

if [ "$NEW_MD5" != "$OLD_MD5" ]
then
  echo "$NEW_MD5 vs. $OLD_MD5"
  echo "File is new, restarting"
  mv /tmp/info_template.html /opt/HBMonv2/templates
  systemctl restart hbmon
else
  echo "File is the same."
fi
