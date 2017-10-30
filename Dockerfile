# start from base golang image which installs golang and sets GOPATH
FROM golang

# allows env_name to be set during build (defaults to empty string)
ARG env_name

# allows env_value to be set during build (defaults to empty string)
ARG env_value

# sets an environment variable to app_env argument
ENV ENV_NAME $env_name

# sets an environment variable to app_env argument
ENV ENV_VALUE $env_value


# copy the local project code into a directory in the container’s GOPATH
COPY ./app /go/src/github.com/arthur0/go-env/app

# set this to the working directory so all subsequent commands will run from this directory
WORKDIR /go/src/github.com/arthur0/go-env/app

# install all dependencies
RUN go get ./

# build the binary
RUN go build

# run the binary
CMD app

# This is the port the app was programed to serve on
EXPOSE 80