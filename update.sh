#!/bin/bash
set -e

rubyBase='2.1'
rubyOnbuildDockerfile="https://raw.githubusercontent.com/docker-library/ruby/master/$rubyBase/onbuild/Dockerfile"

current="$(curl -sSL 'https://rubygems.org/api/v1/gems/padrino.json' | sed -r 's/^.*"version":"([^"]+)".*$/\1/')"

set -x

curl -sSL "$rubyOnbuildDockerfile" -o onbuild/Dockerfile
echo >> onbuild/Dockerfile
grep '^RUN.*apt-get install' Dockerfile >> onbuild/Dockerfile
echo >> onbuild/Dockerfile
echo 'EXPOSE 3000' >> onbuild/Dockerfile
echo 'CMD ["padrino", "start"]' >> onbuild/Dockerfile

sed -ri '
	s/^FROM .*/'"$(grep '^FROM' onbuild/Dockerfile | head -1)"'/;
	s/^(ENV PADRINO_VERSION) .*/\1 '"$current"'/
' Dockerfile
