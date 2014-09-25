# What is Padrino

Padrino is an open source web application framework which runs via the Ruby programming language.
It is a full-stack framework: it allows creating pages and applications that gather information
from the web server, talk to or query the database, and render templates out of the box.
As a result, Padrino features a routing system that is independent of the web server.

> [wikipedia.org/wiki/Padrino_(web_framework)](https://en.wikipedia.org/wiki/Padrino_(web_framework))

# How to use this image

## Create a `Dockerfile` in your padrino app project

    FROM padrino:onbuild

Put this file in the root of your app, next to the `Gemfile`.

This image includes multiple `ONBUILD` triggers so that should be all that you need for most applications. The build will `ADD . /usr/src/app`, `RUN bundle install`, `EXPOSE 3000`, and set the default command to `padrino start`.

Then build and run the docker image.

    docker build -t my-padrino-app .
    docker run --name some-padrino-app -d my-padrino-app

Test it by visiting `http://container-ip:3000` in a browser. On the other hand, if you need access outside the host on port 8080:

    docker run --name some-padrino-app -p 8080:3000 -d my-padrino-app

Then hit `http://localhost:8080` or `http://host-ip:8080` in a browser.
