---
layout: post
title: Installing Google Go on OSX Snow Leopard
---

## How to install the Go programming language on OSX Snow Leopard

### Assumptions

Before you follow these steps, you should have [XTools][1] installed. You should also be running Snow Leopard as your OS.

These instructions should also work for Leopard, although you may have to use GOARCH=386.

All of these steps will be performed in Terminal

## Step 1 - Directories and Environment Variables

Google Go has a number of environment variables that are required when running: `$GOROOT`, `$GOOS`, `$GOARCH` and `$GOBIN`. You can find out more about these variables at by reading [Go's general installation document][2].

For our purposes, we are going to use the following settings:

`
GOROOT=$HOME/Go<br />
GOOS=darwin<br />
GOARCH=amd64<br />
GOBIN=$HOME/bin<br />
`
You can use the following command to automatically place them at the end of your ~/.bashrc file:

    cat >> ~/.bashrc <<EOF

    export GOROOT=\$HOME/Go
    export GOOS=darwin
    export GOARCH=amd64
    export GOBIN=\$HOME/bin
    EOF


Now use the `source` command to apply those changes to your current session:

    source ~/.bashrc

Also, we have to create the bin directory and add it to your system paths:

    mkdir -p $HOME/bin
    echo "$HOME/bin" > go
    sudo mv go /etc/paths.d/
    eval `/usr/libexec/path_helper -s`

<p style="background-color: #ffe; padding: 3px;">
  For more information on the /etc/paths.d/ setup in Leopard, you can read <a href="http://littlesquare.com/2008/01/24/upgraded-to-leopard-making-use-of-etcpathsd-and-path_helper/">this blog post on paths</a>.
</p>

## Step 2 - Getting The Source

Google is using [Mercurial][3] to handle the source code. If you don't already have it installed, you can install it quickly and easily with the following command:

    sudo easy_install mercurial

This will automatically install the mercurial package on your system. Once that is done, you can run the `hg` command to checkout Go's source:

    hg clone -r release https://go.googlecode.com/hg/ $GOROOT


The source code will be checked out to the $GOROOT that we specified in the .bashrc settings.

## Step 3 - Installation

<p style="background-color: #ffe; padding: 3px;">
  From this point on, you've done the custom OSX bits. The following are essentially the same instructions as <a href="http://golang.org/doc/install.html#tmp_17">Go's official installation document</a>.
</p>

Head over to the $GOROOT src directory and then run all.bash, the installation script:

    cd $GOROOT/src
    ./all.bash

Once the installation is done, you should see the following output at the end:

    --- cd ../test
    N known bugs; 0 unexpected bugs

This means you're ready to start [writing and compiling Go][4]. Congratulations!

## Optional Step 4 - Quick compile and linking script

I created a very simple bash script called `go` that compiles and links the file in one step. You're welcome to add this as an addition to your commands. Just run the following command to set it up:

    cat >> $GOBIN/go <<EOF
    #! /bin/bash
    if [ ! \$1 ]; then
      echo "Usage: go name_of_file (without the .go)"
      exit
    fi
    6g \$1.go
    6l \$1.6
    EOF
    chmod +x $GOBIN/go



Now you can compile and link in one go ( \*snicker\* ). If your filename is `hello.go`, you can use it like this:

    go hello

Nice 'n easy. :)

 [1]: http://developer.apple.com/TOOLS/Xcode/
 [2]: http://golang.org/doc/install.html#tmp_17
 [3]: http://mercurial.selenic.com/wiki/Download
 [4]: http://golang.org/doc/install.html#tmp_71