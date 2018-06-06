#Run unit tests

set -o monitor
echo "###############################"
echo "# Runing Available Unit Tests #"
echo "###############################"

npm run test-coverage

echo "#####################################"
echo "# Runing Available Regression Tests #"
echo "#####################################"

npm run test-regression

echo "######################################"
echo "# Runing Available Integration Tests #"
echo "######################################"

echo "Starting webserver..."

# Start a webserver to view the integration tests
node ./node_modules/http-server/bin/http-server &

echo "Detecting OS..."

# Detect the OS
# Credit for this - http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

# Arbitrary time for http-server to start - FixMe
sleep 1

echo "Opening browser to run integration tests..."

# Run integration tests
if [[ $platform == 'linux' ]]; then
    xdg-open http://localhost:8080/test/integration/
elif [[ $platform == 'unknown' ]]; then
    open http://localhost:8080/test/integration/
fi

echo
echo "Bring webserver process to foreground...(CTRL+C to kill)"
echo

# Bring the server process to the foreground so it can be killed
fg %1
