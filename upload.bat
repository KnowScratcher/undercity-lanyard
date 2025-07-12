@echo off

echo "Welcome to Undercity Broken Lanyard Upload Script"

del img.png 2>NUL
del img_resized.png 2>NUL
del newbadge.bmp 2>NUL


:: Ask for name of the user
set /p name="Please enter your name: "
echo "Hello, %name%!"
:: Ask for slack handle
set /p slack_handle="Please enter your slack handle: @"
echo "Thank you, %slack_handle%! Let's proceed with the upload."
:: Change the img to add the text

:: Optional pronouns
set /p pronouns="Any text you want to add?: "

set /p image_url="Any image you want to add? (res is broken u know it + .png only + path pliz) : "
:: Download the image if provided

if not "%image_url%"=="" (
    copy "%image_url%" img.png
else
    echo "No img, you're not funni"
)

:: if img exists, resize it to 64x64

if exist img.png (
    echo "Resizing image to 64x64..."
    magick img.png -resize 64x64 img_resized.png
else
    echo "Image not found, skipping resize."
)


:: Img
:: Calculate the width of the name text to position pronouns correctly
for /f "tokens=3 delims= " %%a in ('magick -font "./font.ttf" -pointsize 25 -size 1000x100 xc:transparent -annotate +0+0 "%name%" -trim info:') do (
    for /f "tokens=1 delims=x" %%b in ("%%a") do (
        set /a name_width=%%b
    )
)
set /a pronoun_x=20 + %name_width% + 20  :: Add 10 pixels spacing between name and pronouns

magick badge.bmp ^
  -font "./font.ttf" -pointsize 25 -fill black ^
  -annotate +20+30 "%name%" ^
  -annotate +20+60 "@%slack_handle%" ^
  -pointsize 15 -font "./bankfont.ttf" -annotate +%pronoun_x%+30 "%pronouns%" ^
  newbadge.bmp

:: if the img exists, overlay it on the badge

if exist img_resized.png (
    echo "Overlaying image on the badge..."
    magick newbadge.bmp img_resized.png -geometry +220+5 -composite newbadge.bmp
)

:: Convert it to a format suitable for the device

call "%USERPROFILE%\anaconda3\Scripts\activate.bat"
python bmp_to_array.py newbadge.bmp f.h gImage_img
call conda deactivate

arduino-cli compile --fqbn rp2040:rp2040:generic_rp2350 --output-dir ./build
if %errorlevel% neq 0 (
    echo "Compilation failed. Please check the code."
    exit 1
)
echo "Please press the boot button on the device and press enter when plugged in"
:: Wait for the user to press enter
pause
:: Upload the compiled binary to the device
copy build\undercity-lanyard.ino.uf2 E:\ 2>NUL
if %errorlevel% neq 0 (
    echo "Upload failed. Please check the device connection."
    echo "Attempting to copy to a generic drive letter. Please ensure your RP2350 is mounted as a drive."
    echo "If your RP2350 is mounted under a different drive letter, please manually copy 'build\undercity-lanyard.ino.uf2' to it."
    exit /b 1
)
echo "Upload successful! The device should now be running the new code."
pause