Import-Csv C:\pokon\ttpsc\test1.csv | ForEach-Object {
$user = get-mailbox -Identity $_.name
set-mailbox $user -PrimarySmtpAddres $_.email
}