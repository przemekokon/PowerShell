Add-PSSnapin "VMware.VimAutomation.Core"

$Header = @"
<style>
<br>
<br>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@
$global:i=0
#import credentiali
$import_pass = Get-Content C:\skrypt\importvm\pass2.txt | ConvertTo-SecureString
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'domain\user',$import_pass
#podpiecie do serwera
Connect-VIServer nazwa_serwera -Credential $cred

Get-VM |
Select @{Name="Item#";Expression={$global:i++;$global:i}},
Name,
@{N="IP Address";E={@($_.guest.IPAddress[0])}},
@{N='ResourcePool';E={Get-ResourcePool -VM $_ | Select -ExpandProperty Name}},
@{N="ESX Host";E={Get-VMHost -VM $_}}, 
@{N='PowerState';E={$_.ExtensionData.Runtime.PowerState}},
@{N="Cluster";E={Get-Cluster -VM $_ }} |
#@{N="Running OS";E={$_.Guest}} | w razie potrzeby, dopisac wyzej przecinek i usunac znak '|'

ConvertTo-Html -Head $Header >  C:\listavm\vmware.html
