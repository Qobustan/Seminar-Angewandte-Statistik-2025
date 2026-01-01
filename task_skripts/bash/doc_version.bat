@echo off
REM Script to commit and push documentation changes

setlocal

echo Committing documentation changes...

git add . || exit /b 1
git commit -m "Update documentation and LaTeX files" || exit /b 1
git push origin main || exit /b 1

echo Changes pushed successfully!
