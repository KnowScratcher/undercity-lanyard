# Undercity eink lanyard

## How to flash it (windows)

1. Clone the repo
    ```bash
    git clone
    ```
2. install python, arduino-cli & imagemagick (you can find them is their website download)

    arduino-cli config add board_manager.additional_urls https://github.com/earlephilhower/arduino-pico/releases/download/global/package_rp2040_index.json

    arduino-cli lib install "Adafruit NeoPixel"

    arduino-cli core install rp2040:rp2040
    ```

3. check the disk index when you plug your board in (for me it's `E:`), if it's not `E:`, please go to upload.bat line 78 col 38 and change it to the correct disk.
4. Just run the script
    ```bash
    upload.bat
    ```
5. Follow the instructions and yay!

## How to flash it (mac)

__Note : only works on macos :/__

1. Clone the repo
    ```bash
    git clone
    ```
2. You need anaconda, imagemagick installed & arduino-cli. Install anaconda using this [link](https://www.anaconda.com/docs/getting-started/anaconda/install#macos-linux-installation) (USE THE COMMAND LINE INSTALLER)
    ```bash
    # arduino cli
    brew install arduino-cli

    # imagemagick
    brew install imagemagick

    arduino-cli config add board_manager.additional_urls https://github.com/earlephilhower/arduino-pico/releases/download/global/package_rp2040_index.json

    arduino-cli lib install "Adafruit NeoPixel"
    ```
3. Just run the script
    ```bash
    chmod +x upload.sh
    ./upload.sh
    ```
4. Follow the instructions and yay!


## Wooo

<img width="547" height="720" alt="image" src="https://github.com/user-attachments/assets/4808eedb-61ba-4868-983b-0e15dcd37818" />
