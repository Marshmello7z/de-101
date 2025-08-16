$dst = "C:\Users\Admin\de-101\Module4\superstore\sample-superstore-shell.xls"
$uri = "https://github.com/Data-Learn/data-engineering/raw/refs/heads/master/DE-101%20Modules/Module01/DE%20-%20101%20Lab%201.1/Sample%20-%20Superstore.xls"

New-Item -ItemType Directory -Path (Split-Path $dst) -Force | Out-Null
Invoke-WebRequest -Uri $uri -OutFile $dst -UseBasicParsing
