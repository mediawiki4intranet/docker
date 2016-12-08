<?php

require_once 'LocalSettings-noVE.php';

require_once "$IP/extensions/VisualEditor/VisualEditor.php";
$wgVirtualRestConfig['modules']['parsoid'] = array(
    'url' => 'http://localhost:8142',
    'forwardCookies' => true,
);
$wgDefaultUserOptions['visualeditor-enable'] = 1;
require_once "$IP/extensions/TemplateData/TemplateData.php";
