param (
    [Parameter(Mandatory)] $architecture
)

$ErrorActionPreference = "Stop"

if ($architecture -eq "x64") {
    $platform = "x64"
} else {
    $platform = "Win32"
}

Set-Location builds\msvc\vs2019
msbuild /t:Build /p:Configuration=StaticRelease /p:Platform=$platform libsodium.sln
msbuild /t:Build /p:Configuration=DynRelease /p:Platform=$platform libsodium.sln
Set-Location ..\..\..
New-Item winlibs -ItemType "directory"
xcopy bin\$platform\Release\v142\dynamic\libsodium.dll winlibs\bin\*
xcopy bin\$platform\Release\v142\dynamic\libsodium.pdb winlibs\bin\*
xcopy /e src\libsodium\include\*.h winlibs\include\*
Remove-Item winlibs\include\sodium\private -Recurse
xcopy bin\$platform\Release\v142\dynamic\libsodium.lib winlibs\lib\*
Copy-Item bin\$platform\Release\v142\static\libsodium.lib winlibs\lib\libsodium_a.lib
