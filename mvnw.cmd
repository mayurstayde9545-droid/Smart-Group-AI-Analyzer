@echo off
setlocal

rem Download a pinned Maven distribution on first use; no global Maven install is needed.
set "MAVEN_VERSION=3.9.9"
set "MAVEN_BASE=%USERPROFILE%\.m2\wrapper\dists\apache-maven-%MAVEN_VERSION%"
set "MAVEN_HOME=%MAVEN_BASE%\apache-maven-%MAVEN_VERSION%"
set "MAVEN_ZIP=%MAVEN_BASE%\apache-maven-%MAVEN_VERSION%-bin.zip"

if exist "%MAVEN_HOME%\bin\mvn.cmd" goto runMaven
if not exist "%MAVEN_BASE%" mkdir "%MAVEN_BASE%"
echo Downloading Apache Maven %MAVEN_VERSION% for the first run.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri 'https://archive.apache.org/dist/maven/maven-3/%MAVEN_VERSION%/binaries/apache-maven-%MAVEN_VERSION%-bin.zip' -OutFile '%MAVEN_ZIP%'"
if errorlevel 1 goto failed
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%MAVEN_ZIP%' -DestinationPath '%MAVEN_BASE%' -Force"
if errorlevel 1 goto failed

:runMaven
if not exist "%MAVEN_HOME%\bin\mvn.cmd" goto failed
call "%MAVEN_HOME%\bin\mvn.cmd" %*
exit /b %ERRORLEVEL%

:failed
echo Maven setup failed. Check your internet connection, then try again.
exit /b 1
