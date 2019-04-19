ARG swift_version=5.0
ARG ubuntu_version=bionic
FROM swift:$swift_version-$ubuntu_version
# needed to do again after FROM due to docker limitation
ARG swift_version
ARG ubuntu_version

# dependencies
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y lsof dnsutils netcat-openbsd net-tools # used by integration tests

# ruby and jazzy for docs generation
RUN apt-get update && apt-get install -y ruby ruby-dev libsqlite3-dev
RUN gem install jazzy --no-ri --no-rdoc

# tools
RUN mkdir -p $HOME/.tools
RUN echo 'export PATH="$HOME/.tools:$PATH"' >> $HOME/.profile

# swift-api-digester for comparing API changes
ARG swift_api_digester_version=5.0.1
RUN wget -q https://apple.bintray.com/tools/swift-api-digester-$swift_api_digester_version.tar.gz -O "$HOME/.tools/swift-api-digester-$swift_api_digester_version.tar.gz"
RUN tar -xzvf "$HOME/.tools/swift-api-digester-$swift_api_digester_version.tar.gz" -C "$HOME/.tools"

# script to allow mapping framepointers on linux
#RUN wget -q https://raw.githubusercontent.com/apple/swift/master/utils/symbolicate-linux-fatal -O $HOME/.tools/symbolicate-linux-fatal
#RUN chmod 755 $HOME/.tools/symbolicate-linux-fatal
