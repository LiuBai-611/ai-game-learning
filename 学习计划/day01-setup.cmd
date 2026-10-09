@echo off
REM ============================================================
REM  Day 01 setup: configure Git
REM  Just double-click this file.
REM
REM  NOTE: the log file is created in English (ASCII) on purpose,
REM  because cmd.exe redirection garbles Chinese text. You will
REM  paste the Chinese template in afterwards.
REM ============================================================

REM ---- locate git: 1) PATH  2) common install locations ----
set "GIT="
for /f "delims=" %%i in ('where git 2^>nul') do if not defined GIT set "GIT=%%i"
if not defined GIT if exist "D:\dev\Git\cmd\git.exe" set "GIT=D:\dev\Git\cmd\git.exe"
if not defined GIT if exist "%ProgramFiles%\Git\cmd\git.exe" set "GIT=%ProgramFiles%\Git\cmd\git.exe"
if not defined GIT if exist "%LOCALAPPDATA%\Programs\Git\cmd\git.exe" set "GIT=%LOCALAPPDATA%\Programs\Git\cmd\git.exe"
if not defined GIT (
  echo [ERROR] git not found.
  echo         Install Git for Windows first (https://git-scm.com/download/win),
  echo         then close this window and run this script again.
  pause
  exit /b 1
)
echo Using git: %GIT%
echo.

echo ============================================================
echo   Git setup  (Day 01)
echo ============================================================
echo.
echo Use the SAME email as your GitHub account (LiuBai-611).
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
REM 只回显 name / email 两项。不要用 --list：它会把全部全局配置（含凭证助手等）
REM 一起打印出来，而这段输出是要截图发给别人核对的。
"%GIT%" config --global user.name
"%GIT%" config --global user.email

echo.
echo -- note --
echo   This script does NOT create the log file any more.
echo   D:\dev\ai-game-learning must stay EMPTY for step 2
echo   (git clone ... .) to work. Create the log in step 4.

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
echo       git config --global user.name
echo.
pause
