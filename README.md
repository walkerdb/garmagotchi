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

|                                                                                                                                                               |                                                                                                                                                               |                                                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img width="730" alt="Screenshot 2023-11-03 at 9 17 17 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/60de30aa-4bf9-4fc4-b5f5-2b387673440c"> | <img width="730" alt="Screenshot 2023-11-03 at 9 17 20 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/c50ae9df-33a1-4342-94d6-103e29d2c61f"> | <img width="730" alt="Screenshot 2023-11-03 at 9 15 55 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/ef0ccdb9-6e05-499c-9dcb-30dc2c754a97"> |
| <img width="730" alt="Screenshot 2023-11-03 at 9 21 38 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/326116bb-a673-4245-9029-005e16eaeb9c"> | <img width="730" alt="Screenshot 2023-11-03 at 9 22 41 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/7632eccd-e8e3-4098-9ef0-a687d116ba2c"> | <img width="730" alt="Screenshot 2023-11-03 at 9 22 58 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/9ccf3c82-6e17-46ae-8a88-bc1ad4cb7d05"> |
| <img width="730" alt="Screenshot 2023-11-03 at 9 27 32 PM" src="https://github.com/walkerdb/garmagotchi/assets/1877652/578132bc-ee26-4131-b7ed-db0f8a0799df"> |                                                                                                                                                               |                                                                                                                                                               |
