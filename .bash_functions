# Make a directory and cd into it
#
function mkcd () {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}


# Run rake with local env vars if .env file is found.
#
function rake {
  if [ -f ".env" ]; then
    source .env && `which rake` $@
  else
    `which rake` $@
  fi
}


# Restart Blueprint under Passenger and issue a request to spin it up.
#
function brake {
  if test -d "tmp"; then
    touch "tmp/restart.txt" && echo "Restarted.";
  else
    echo "You are not in a Rails directory.";
  fi;
}
