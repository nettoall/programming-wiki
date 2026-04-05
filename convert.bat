@echo off
for %%f in (*.html) do (
    pandoc "%%f" -f html -t gfm --wrap=none --extract-media=./media -o "%%~nf.md"
)
echo Done
pause