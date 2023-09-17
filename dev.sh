#!/bin/sh
export GUM_INPUT_PROMPT_FOREGROUND="212"

BUILD_FAILED="false"

function install_reqs {
  if ! command -v "fswatch" &> /dev/null ; then
    echo "installing fswatch to track file-system changes...\n"
    brew install fswatch
  fi

  if ! command -v "gum" &> /dev/null ; then
    echo "installing gum for cli formatting...\n"
    brew install gum
  fi
}

function start_sim_if_not_running {
  running_sim_pid="$(ps aux | grep simulator | grep 'ConnectIQ' | grep -v 'grep' | awk '{print $2}')"

  # open the sim if it's not running
  if [[ -z "$running_sim_pid" ]]; then
    connectiq
  fi
}

# makes the monkeyc build output more readable by adding red/yellow/blue highlighting 
# for errors, warnings, and successes respectively.
function colorize_build_output {
  while read -r line; do
    if [[ $line == *"BUILD SUCCESSFUL"* ]]; then
      echo "${line//BUILD SUCCESSFUL/\n\033[34mBUILD SUCCESSFUL\033[0m}"
    elif [[ $line == *"WARNING:"* ]]; then
      echo "${line//WARNING: $device:/\033[33mWARNING\033[0m}"
    elif [[ $line == *"ERROR:"* ]]; then
      echo "${line//ERROR: $device:/\033[31mERROR\033[0m}"
    else
      echo "$line"
    fi
  done
}

# a gross hack to get gum's spinners to work in the way we'd like to use them.
# see the comment on the build function for more info.
CURRENT_SPINNER_PID=-1
function start_spinner {
  local title=$1
  gum spin -s line --title "${title}" --show-output -- sleep 10 &
  CURRENT_SPINNER_PID=$!
  disown $CURRENT_SPINNER_PID
}

function build {
  # we want to show a spinner _and_ colorize the output of the build command.
  # normally you'd just call 'gum spin --show-output -- monkeyc... | colorize_build_output' 
  # but gum's spin command surprisingly makes this impossible. So instead we're starting the
  # spinner to run indefinitely in a background process, then manually killing it after the
  # build completes.
  start_spinner "Building..."
  build_logs=$(monkeyc \
    -o bin/garmagotchi.prg \
    -f monkey.jungle \
    -y ./developer_key \
    -d "${device}"_sim \
    -w 2>&1 | colorize_build_output)

  if [[ $build_logs == *"ERROR"* ]]; then
    BUILD_FAILED="true"
  else
    BUILD_FAILED="false"
  fi

  header=$(gum style --faint "📝 Build log")
  gum style \
    --border-foreground 8 \
    --border double \
    --width 100 \
    --margin "0 0 1 0" \
    --padding "1 2" \
    "$(gum join --vertical "${header}" "" "${build_logs}")"

  kill $CURRENT_SPINNER_PID > /dev/null 2>&1
}

function send_build_to_device {
  # upload the build to the sim as a shell background job.
  # we're backgrounding it because this command seems not to exit on its own.
  # we will manually force it closed after a set amount of time has passed.
  monkeydo bin/garmagotchi.prg "${device}" &> /dev/null &

  # get the process ID of the new background job, then remove it from the list of background jobs so that it doesn't 
  # print to the console when we kill it later
  MONKEYDO_PID=$!
  disown $MONKEYDO_PID

  # give it time to finish uploading. 
  sleep 1

  # force the monkeydo process to stop
  kill $MONKEYDO_PID > /dev/null 2>&1
}

function send_build_to_device_with_spinner {
  send_build_to_device &
  # 2 seconds seems to be just about the right amount of time for the sim to finish refreshing
  gum spin -s line --title "Sending to device..." -- sleep 2
  echo "🚀 Update ready!\n"
}

function run_build_and_send_to_sim_on_file_change {
  gum style --foreground 212 '🦻 Now listening for file changes!'
  gum style --foreground 8 --italic 'The app will automatically rebuild and refresh in the sim when changes are detected.'
  echo
  fswatch -o -r ./source ./resources manifest.xml | while read -r changed_file; do
    build_and_send_to_device
  done
}

function build_and_send_to_device {
  build
  if [[ $BUILD_FAILED == 'false' ]]; then
    send_build_to_device_with_spinner
  else
    gum style --foreground 1 "🚨 Build failed! Use the logs above to help fix the issue."
    echo
  fi
}

install_reqs

echo
echo "Which sim would you like to use?"
echo
# extract supported devices from the manifest.xml file and pass them to the 'gum choose' command
device="$(grep -o 'iq:product id="[^"]*' manifest.xml | sed 's/iq:product id="//' | gum choose)"
echo "👍 Running in dev mode and compiling for the $(gum style --foreground 212 "${device}") sim!"
echo

start_sim_if_not_running

# run an initial build
build_and_send_to_device

# start watching for file changes
run_build_and_send_to_sim_on_file_change
