# Make a directory and cd into it.
#
function mkcd () {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}


# Run rake with local env vars if .env file is found, and via Bundler
# if Gemfile is found. (You can skip this by using 'realrake' instead.)
#
function rake () {
  local rakecmd

  if [ -s ".env" ]; then
    source .env
  fi

  if [ -f "Gemfile" ]; then
    rakecmd="bundle exec rake"
  else
    rakecmd=`which rake`
  fi

  $rakecmd $@
}


# Run the real rake, rather than guessing.
#
function realrake () {
  `which rake` $@
}


# Restart a Rails app running under Apache/Passenger.
#
function brake () {
  if test -d "tmp"; then
    touch "tmp/restart.txt" && echo "Restarted.";
  else
    echo "You are not in a Rails directory.";
  fi;
}
