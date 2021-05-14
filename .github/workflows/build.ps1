Set-Location builds\msvc\vs2019
msbuild /t:Build /p:Configuration=StaticRelease /p:Platform=x64 libsodium.sln
