# Skrypt pobierający i zapisujący do pliku HTML listę maszyn wirtualnych z serwerów Hyper-V.

#Import credentiali do konta które pobierze VMki
$import_pass = Get-Content C:\test\pass.txt | ConvertTo-SecureString
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'domain\user',$import_pass

$Header = @"
<style>
<br>
<br>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@
$global:i=0
#import z pierwszego serwera
$waw = { import-module VirtualMachineManager; get-vm -VMMServer nazwa_serwera  |  select @{Name="Item#";Expression={$global:i++;$global:i}},Name,VirtualMachineState,Hostname,OperatingSystem,IsHighlyAvailable,IsRecoveryVM,IsPrimaryVM}
$lista = Invoke-Command -ComputerName nazwa_serwera -ScriptBlock $waw -Credential $cred
$lista | ConvertTo-Html -Head $Header > C:\listavm\plik1.html
import-module VirtualMachineManager
#import z drugiego serwera
$ldz = get-vm -VMMServer nazwa_serwera | select @{Name="Item#";Expression={$global:i++;$global:i}},Name,VirtualMachineState,Hostname,OperatingSystem,IsHighlyAvailable,IsRecoveryVM,IsPrimaryVM
$ldz | ConvertTo-Html -Head $Header >  C:\listavm\plik2.html