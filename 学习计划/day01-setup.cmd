@echo off
REM ============================================================
REM  Day 01 setup: configure Git
REM  Just double-click this file.
REM
REM  NOTE: the log file is created in English (ASCII) on purpose,
REM  because cmd.exe redirection garbles Chinese text. You will
REM  paste the Chinese template in afterwards.
REM ============================================================

set "GIT=D:\dev\Git\cmd\git.exe"
if not exist "%GIT%" (
  echo [ERROR] git not found at %GIT%
  pause
  exit /b 1
)

echo ============================================================
echo   Git setup  (Day 01)
echo ============================================================
echo.
echo Use the SAME email as your GitHub account (Liubai-611).
echo The name is only a label, it can be your nickname.
echo.
set /p GNAME=  Your name or nickname:
set /p GMAIL=  Your GitHub email:

if "%GNAME%"=="" (
  echo [ERROR] name cannot be empty.
  pause
  exit /b 1
)
if "%GMAIL%"=="" (
  echo [ERROR] email cannot be empty.
  pause
  exit /b 1
)

echo.
echo -- writing global config --
"%GIT%" config --global user.name "%GNAME%"
"%GIT%" config --global user.email "%GMAIL%"
"%GIT%" config --global core.autocrlf true
"%GIT%" config --global init.defaultBranch main
"%GIT%" config --global core.quotepath false
"%GIT%" config --global credential.helper manager

echo.
echo -- result --
"%GIT%" config --global --list

echo.
echo -- creating the log file --
set "LOG=D:\dev\ai-game-learning\学习日志.md"
if not exist "D:\dev\ai-game-learning" mkdir "D:\dev\ai-game-learning"

if exist "%LOG%" (
  echo   already exists, leaving it alone:
  echo   %LOG%
) else (
  > "%LOG%" echo # Learning Log
  >>"%LOG%" echo.
  >>"%LOG%" echo ^> Paste the Chinese template from the learning plan
  >>"%LOG%" echo ^> folder here on first use.
  >>"%LOG%" echo.
  >>"%LOG%" echo ## Daily Record
  >>"%LOG%" echo.
  >>"%LOG%" echo ^| Date ^| Day ^| What I did ^| Concept I understood ^| Where I got stuck ^| First thing tomorrow ^|
  >>"%LOG%" echo ^|---|---|---|---|---|---^|
  echo   created: %LOG%
)

echo.
echo ============================================================
echo   Done. Git is configured.
echo ============================================================
echo.
echo   !! IMPORTANT !!
echo   Close this window, then open a NEW terminal
echo   (press Win+R, type cmd, press Enter) so the new PATH
echo   takes effect. Then run:
echo.
echo       git --version
echo       git config --global --list
echo.
pause
