@echo off
setlocal

rem Download a pinned Maven distribution on first use; no global Maven install is needed.
set "MAVEN_VERSION=3.9.9"
set "MAVEN_BASE=%USERPROFILE%\.m2\wrapper\dists\apache-maven-%MAVEN_VERSION%"
set "MAVEN_HOME=%MAVEN_BASE%\apache-maven-%MAVEN_VERSION%"
set "MAVEN_ZIP=%MAVEN_BASE%\apache-maven-%MAVEN_VERSION%-bin.zip"

if not exist "%MAVEN_HOME%\bin\mvn.cmd" (
  if not exist "%MAVEN_BASE%" mkdir "%MAVEN_BASE%"
  echo Downloading Apache Maven %MAVEN_VERSION% (first run only)...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri 'https://archive.apache.org/dist/maven/maven-3/%MAVEN_VERSION%/binaries/apache-maven-%MAVEN_VERSION%-bin.zip' -OutFile '%MAVEN_ZIP%'"
  if errorlevel 1 exit /b 1
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%MAVEN_ZIP%' -DestinationPath '%MAVEN_BASE%' -Force"
  if errorlevel 1 exit /b 1
)

call "%MAVEN_HOME%\bin\mvn.cmd" %*
exit /b %ERRORLEVEL%
