#!bash

latest_runner_version=$(curl -I -v -s https://github.com/actions/runner/releases/latest 2>&1 | perl -ne 'next unless s/^< location: //; s{.*/v}{}; s/\s+//; print')

cd /home/$(whoami)/agent
source ./env.sh

if [ "$RUNNER_VERSION" = "$latest_runner_version" ]; then
    echo "Runner is already up to date."
    exit 0
fi

echo "Installing latest version ($latest_runner_version)"
curl -sL "https://github.com/actions/runner/releases/download/v${latest_runner_version}/actions-runner-linux-x64-${latest_runner_version}.tar.gz" | tar xzvC /home/$(whoami)/agent
sudo /home/$(whoami)/agent/bin/installdependencies.sh