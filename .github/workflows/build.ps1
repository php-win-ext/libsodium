Set-Location builds\msvc\vs2019
msbuild /t:Build /p:Configuration=StaticRelease /p:Platform=x64 libsodium.sln
msbuild /t:Build /p:Configuration=DynRelease /p:Platform=x64 libsodium.sln
Set-Location ..\..\..
mkdir winlibs
xcopy bin\x64\Release\v142\dynamic\libsodium.dll winlibs\bin\*
xcopy bin\x64\Release\v142\dynamic\libsodium.pdb winlibs\bin\*
xcopy /e src\libsodium\include\*.h winlibs\include\*
rmdir /s /q winlibs\include\sodium\private
del winlibs\include\sodium\randombytes_nativeclient.h
xcopy bin\x64\Release\v142\dynamic\libsodium.lib winlibs\lib\*
copy bin\x64\Release\v142\static\libsodium.lib winlibs\lib\libsodium_a.lib
