<?php

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

require_once __DIR__.'/../vendor/autoload.php';


$conf = yaml_parse_file('config.yaml');

$phpVersion = $conf['phpVersion'];
$phpMode = $conf['phpMode'];
$includeModules = $conf['includeModules'];
$modulesRawData = [];


$includeModules = array_unique($includeModules);

foreach ($includeModules as $item) {
    $modeFile = 'src/php'.$phpVersion.'-'.$phpMode.'/parts/'.$item.'.Dockerfile';
    if(!file_exists($modeFile)) {
        echo "module $item not found\n";
        continue;
    }
    $modulesRawData[$item] = file_get_contents($modeFile);
}
ksort($modulesRawData);

$loader = new FilesystemLoader('src/php'.$phpVersion.'-'.$phpMode);
$twig = new Environment($loader, ['debug' => true]);
$template = $twig->load('template.Dockerfile');

$output = $template->render(['modules' => $modulesRawData ]);


$f=fopen('dist/Dockerfile','w');
fwrite($f,$output);
fclose($f);
shell_exec('cp -rvf src/php'.$phpVersion.'-'.$phpMode.'/static/* dist/');