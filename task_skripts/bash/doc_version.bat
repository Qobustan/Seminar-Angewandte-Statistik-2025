@echo off
REM Script to commit and push documentation changes

setlocal

echo Committing documentation changes...

git add .
git commit -m "Update documentation and LaTeX files"
git push origin main

echo Changes pushed successfully!
