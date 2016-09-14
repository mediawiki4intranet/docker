<?php

require_once 'configs/ServerSettings.php';

$wgEmergencyContact     = 'wiki-daemon@wiki4intranet.local';
$wgPasswordSender       = 'wiki-daemon@wiki4intranet.local';
$wgAdditionalMailParams = "-f$wgPasswordSender";

$wgSitename = 'Wiki4Intranet';
$wgDBtype = 'mysql';
$wgDBname = 'mediawiki';
$wgDBuser = 'mediawiki';
$wgDBpassword = 'mediawiki';
$wgDBadminuser = $wgDBuser;
$wgDBadminpassword = $wgDBpassword;
$wgDBprefix = '';
$wgScriptPath = '/';

require_once 'extensions/SphinxSearchEngine/SphinxSearchEngine.php';
$wgSphinxQL_index = $wgDBuser;
$wgSphinxQL_port = '/var/run/sphinxsearch/searchd.sock';
$wgSphinxSE_port = 3112;

$egFavRateLogVisitors = true;
$egFavRatePublicLogs = true;

$wgShowSQLErrors = true;
