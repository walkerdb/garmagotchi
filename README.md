# Garmagotchi!

A cute little virtual pet for your Garmin watch.

## Setup

1. Install the Garmin ConnectIQ SDK and follow its [setup instructions](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/#theconnectiqsdkmanager).
2. Install Garmin's MonkeyC vscode extension.
3. Set up a dev key by running the `Monkey C: Verify Installation` command from your VSCode command pallette (cmd-shift-p). NOTE: you must save this file to the repo root.
4. Make the `connectiq` and `monkeyc` shell commands available by following the [setup instructions](https://developer.garmin.com/connect-iq/reference-guides/monkey-c-command-line-setup/).
5. Run `./dev.sh` from your console to start everything up!

## Development Workflow

1. Run `./dev.sh`
2. That's it! Your app will refresh in the sim after you make any change to the source files.

https://github.com/walkerdb/garmagotchi/assets/7026330/5a737db7-2b82-4764-895a-13886b79b580

## Loading the WatchFace on Your Watch

1. (If using Mac) Install [Android File Transfer](https://www.android.com/filetransfer/) to transfer the PRG file to your watch.
2. In VSCode, open the `garmagotchi` workspace and run the `Monkey C: Build for Device` command from your VSCode command pallette (cmd-shift-p).
3. Running that command should prompt you to select which watch you'd like to build for, where to save your PRG file, and whether you'd like a debug or release build. Choose the release option.
4. Find the `garmagotchi.prg` file in your finder and transfer it to your watch by dragging it it into `GARMIN/apps`.

## Character Previews

### Red Panda

<img width="730" alt="Screenshot 2023-11-03 at 9 17 17 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/60de30aa-4bf9-4fc4-b5f5-2b387673440c">
<img width="730" alt="Screenshot 2023-11-03 at 9 17 20 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/c50ae9df-33a1-4342-94d6-103e29d2c61f">
<img width="730" alt="Screenshot 2023-11-03 at 9 15 55 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/ef0ccdb9-6e05-499c-9dcb-30dc2c754a97">
<img width="730" alt="Screenshot 2023-11-03 at 9 21 38 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/326116bb-a673-4245-9029-005e16eaeb9c">
<img width="730" alt="Screenshot 2023-11-03 at 9 27 32 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/578132bc-ee26-4131-b7ed-db0f8a0799df">
<img width="730" alt="Screenshot 2023-11-03 at 9 22 41 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/7632eccd-e8e3-4098-9ef0-a687d116ba2c">
<img width="730" alt="Screenshot 2023-11-03 at 9 22 58 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/9ccf3c82-6e17-46ae-8a88-bc1ad4cb7d05">

## Axolotl

<img width="730" alt="Screenshot 2023-11-11 at 8 44 41 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/d7b291af-4487-48de-86b5-d3015c161a30">
<img width="730" alt="Screenshot 2023-11-11 at 8 44 44 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/4cff668a-ce60-4dba-a32e-6b9cfa6a2359">
<img width="730" alt="Screenshot 2023-11-11 at 8 45 10 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/8a765694-b6db-4e06-99de-0a49f2e1fcbe">
<img width="730" alt="Screenshot 2023-11-11 at 8 49 06 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/7875f806-8e84-4da4-b3e1-64e4a1de5e98">
<img width="730" alt="Screenshot 2023-11-11 at 8 50 32 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/990052a3-f258-451d-aec5-8c9c9b559fbc">
<img width="730" alt="Screenshot 2023-11-11 at 8 48 21 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/22a86d9f-a97b-4a5c-a633-ca465b05632a">
<img width="730" alt="Screenshot 2023-11-11 at 8 46 48 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/6830f301-a972-4b8e-8806-da52fefd2748">

## Penguin

<img width="730" alt="Screenshot 2023-11-04 at 1 23 29 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/147a2dab-df09-4d4f-8451-ad21c4f07b49">
<img width="730" alt="Screenshot 2023-11-04 at 1 23 16 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/3b4877c9-3b5e-46ad-acbc-77ad9295b99e">
<img width="730" alt="Screenshot 2023-11-04 at 1 22 54 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/3d490605-0446-4589-971e-cb0019752537">
<img width="730" alt="Screenshot 2023-11-04 at 1 24 02 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/1117dcd4-bc08-4d90-8617-62bce8974b04">
<img width="730" alt="Screenshot 2023-11-04 at 1 26 05 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/a7a3e53b-f98d-4469-9628-cb88ac763812">
<img width="730" alt="Screenshot 2023-11-04 at 1 24 50 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/8e662602-a6ed-4e6b-b377-6ec42931165a">
<img width="730" alt="Screenshot 2023-11-04 at 1 24 41 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/9c0d0694-4c87-4a3e-96c9-40b3cc20719a">
