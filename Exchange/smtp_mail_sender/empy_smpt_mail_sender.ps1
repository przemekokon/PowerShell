
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

$import_pass = Get-Content C:\skrypt\smtp_mail_sender\cred.txt | ConvertTo-SecureString
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'ttit\smtp_mail_sender',$import_pass

#wyczyszczenie pliku
Clear-Content -Path C:\skrypt\smtp_mail_sender\out.txt 
#sprawdzenie pustych smtp + generowanie txt
Get-Mailbox 3> C:\skrypt\smtp_mail_sender\out.txt -ResultSize Unlimited | Where-Object {$_.PrimarySMTPAddress -eq $null} 
#sprawdzenie czy txt jest pusty
if ((Get-Content -Path C:\skrypt\smtp_mail_sender\out.txt) -ne $null) 
#Wysylka maila
{
$From = 'smtp_mail_sender@domain.com'
$To = 'powiadomienia@domain.com'
$Subject = 'Konta bez adresu SMTP'
$Body = Get-Content -Path C:\skrypt\smtp_mail_sender\out.txt -Raw
$SMTPServer = 'nasz_host_smtp'
$SMTPPort = '587'
#$Credential = $credentials

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -Port $SMTPPort -Credential $cred
}
else
{
Exit
}
