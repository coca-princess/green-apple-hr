$ErrorActionPreference = 'Stop'
$root = 'c:\Users\86188\CodeBuddy\demo'
$tmp  = Join-Path $env:TEMP 'edgeone-pack'
$out  = Join-Path $root 'edgeone-deploy.zip'

# 1. clean tmp staging dir
if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp }
New-Item -ItemType Directory -Path $tmp | Out-Null

# 2. copy needed files (ASCII-safe names)
Copy-Item -Path (Join-Path $root 'index.html')  -Destination (Join-Path $tmp 'index.html')
Copy-Item -Path (Join-Path $root 'styles.css')  -Destination (Join-Path $tmp 'styles.css')
Copy-Item -Path (Join-Path $root 'app.js')      -Destination (Join-Path $tmp 'app.js')
Copy-Item -Path (Join-Path $root 'favicon.svg') -Destination (Join-Path $tmp 'favicon.svg')

# 3. stage assets/ with sanitized filenames
$assetsDst = Join-Path $tmp 'assets'
New-Item -ItemType Directory -Path $assetsDst | Out-Null
Copy-Item -Path (Join-Path $root 'assets\logo.svg') -Destination (Join-Path $assetsDst 'logo.svg')

# rename the two pngs (remove the colons in timestamps)
$png1 = Get-ChildItem -Path (Join-Path $root 'assets') -Filter 'A_cute_glossy_green_apple_logo_*.png' | Select-Object -First 1
$png2 = Get-ChildItem -Path (Join-Path $root 'assets') -Filter 'A_horizontal_brand_logo_with_a_*.png' | Select-Object -First 1
if ($png1) { Copy-Item -Path $png1.FullName -Destination (Join-Path $assetsDst 'logo-apple.png') }
if ($png2) { Copy-Item -Path $png2.FullName -Destination (Join-Path $assetsDst 'logo-horizontal.png') }

# 4. zip using System.IO.Compression (pure ASCII entry names, no temp files)
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
if (Test-Path $out) { Remove-Item -Force $out }
$zip = [System.IO.Compression.ZipFile]::Open($out, [System.IO.Compression.ZipArchiveMode]::Create)
function Add-ZipEntry($zip, $absPath, $relPath) {
    $entry = $zip.CreateEntry($relPath, [System.IO.Compression.CompressionLevel]::Optimal)
    $writer = New-Object System.IO.StreamWriter($entry.Open(), [System.Text.Encoding]::UTF8)
    $writer.Write([System.IO.File]::ReadAllText($absPath))
    $writer.Dispose()
}
Get-ChildItem -Path $tmp -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Substring($tmp.Length + 1) -replace '\\', '/'
    $entry = $zip.CreateEntry($rel, [System.IO.Compression.CompressionLevel]::Optimal)
    $src = [System.IO.File]::OpenRead($_.FullName)
    $dst = $entry.Open()
    $src.CopyTo($dst); $dst.Dispose(); $src.Dispose()
}
$zip.Dispose()
Remove-Item -Recurse -Force $tmp

# 5. report
Get-Item $out | Select-Object Name, Length, FullName | Format-List
Add-Type -AssemblyName System.IO.Compression.FileSystem
$verify = [System.IO.Compression.ZipFile]::OpenRead($out)
"Entries ({0}):" -f $verify.Entries.Count
$verify.Entries | ForEach-Object { '  {0,8}  {1}' -f $_.Length, $_.FullName }
$verify.Dispose()
