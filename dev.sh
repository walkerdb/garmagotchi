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

function stop_monkeydo_if_running {
  running_monkeydo_pid="$(ps aux | grep bin/monkeydo | grep -v grep |  awk '{print $2}')"
  if [[ -n "$running_monkeydo_pid" ]]; then
    kill "$running_monkeydo_pid"
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

function colorize_runtime_output {
  local in_stack="false"
  while read -r line; do

    if [[ $line == "Stack:"* ]]; then
      in_stack="true"
    elif [[ $line == "Encountered an app crash"* ]]; then
      in_stack="false"
    fi

    if [[ $in_stack == "true" ]]; then
      if [[ $line == "Stack:" ]]; then
        echo "${line}"
      else
        gum style --faint --italic "  ${line}"
      fi
    elif [[ $line == *"Encountered an app crash."* ]]; then
      echo
      gum style --foreground 1 "$line"

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

  kill $CURRENT_SPINNER_PID > /dev/null 2>&1

  gum style --margin "1 0 0 0" "📝 Build log 👇"
  echo
  echo "${build_logs}"
  echo
  echo
}

function print_runtime_logs {
  content=$(cat | colorize_runtime_output)
  if [[ -n "$content" ]]; then
    echo
    echo "👀 Runtime log 👇"
    echo "${content}"
    echo
    echo
  fi
}

function send_build_to_device {
  # upload the build to the sim as a shell background job.
  # it keeps open indefinitely to print runtime logs, so we background it. 
  # we kill the old running process on every new build.
  monkeydo bin/garmagotchi.prg "${device}" 2>&1 | print_runtime_logs &

  # get the process ID of the new background job, then remove it from the list of background jobs so that it doesn't 
  # print to the console when we kill it later
  MONKEYDO_PID=$!
  disown $MONKEYDO_PID
}

function send_build_to_device_with_spinner {
  send_build_to_device &
  # 2 seconds seems to be just about the right amount of time for the sim to finish refreshing
  gum spin -s line --title "Sending to device..." -- sleep 2
  echo "🚀 Update ready!\n"
}

function build_and_send_to_device {
  stop_monkeydo_if_running
  build
  if [[ $BUILD_FAILED == 'false' ]]; then
    send_build_to_device_with_spinner
  else
    gum style --foreground 1 "🚨 Build failed! Use the logs above to help fix the issue."
    echo
  fi
}

function start_watching_files {
  gum style --foreground 4 '🦻 Now listening for file changes!'
  gum style --faint --italic 'The app will automatically rebuild and refresh in the sim when changes are detected.'
  echo
  fswatch --one-per-batch --recursive ./source ./resources manifest.xml | while read -r changed_file; do
    build_and_send_to_device
  done
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

# set up listener to rebuild and reupload to sim on file changes
start_watching_files
