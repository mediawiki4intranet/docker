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

# Short article URLs without /wiki/ and without /index.php/
$wgScriptPath = '';
$wgUsePathInfo = substr($_SERVER['PHP_SELF'], 0, 10) == '/index.php';
$wgArticlePath = "/$1";

$wgLogo    = "$wgScriptPath/configs/logos/wiki4intranet-logo.png";
$wgFavicon = "$wgScriptPath/configs/favicons/wiki4intranet.ico";

$wgLanguageCode = 'en';

require_once 'extensions/SphinxSearchEngine/SphinxSearchEngine.php';
$wgSphinxQL_index = $wgDBuser;
$wgSphinxQL_port = '/var/run/sphinxsearch/searchd.sock';
$wgSphinxSE_port = NULL;

$egFavRateLogVisitors = true;
$egFavRatePublicLogs = true;

//$wgDebugLogFile = '/home/wiki4intranet/data/debug.log';
$wgShowSQLErrors = true;
