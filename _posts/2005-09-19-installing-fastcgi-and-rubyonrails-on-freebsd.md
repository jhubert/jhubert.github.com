---
layout: post
title: Installing FastCGi and RubyOnRails on FreeBSD
category: article
tags: howto rubyonrails
---

## Assumptions

We are going to assume that Apache2 is already installed with mod_fastcgi. We are also going to assume that Ruby has already been installed from Ports. Please see [Appendix 1][1] for a list of installed packages in my environment.

## Step 1

Download the latest version of FastCGI from <http://www.fastcgi.com/dist/>

## Step 2

Install the Rails bindings from Ports

{% highlight bash %}
    cd /usr/ports/www/rubygem-rails
    make install clean
{% endhighlight %}


## Step 3

Install FastCGI from Source

{% highlight bash %}
    tar -xzf fcgi-2.4.0.tar.gz
    cd fcgi-2.4.0
    ./configure
    make install clean
{% endhighlight %}


## Step 4

Install the Ruby FastCGI Bindings using Gem

{% highlight bash %}
    gem install fcgi --
      --with-fcgi-include=/usr/local/include
      --with-fcgi-lib=/usr/local/lib
{% endhighlight %}


## Step 5

To setup the default website, edit your Apache2 configuration file and add the following lines:

{% highlight xml %}
    <Directory /var/www/>
        AllowOverride all
    </Directory>

    LoadModule fastcgi_module modules/mod_fastcgi.so

    AddHandler fastcgi-script .fcgi

    <VirtualHost *:80>
        ServerAdmin webmaster@example.com
        DocumentRoot /var/www/rails/testapp/public
        ServerName www.example.com
        ErrorLog /var/log/httpd/testapp-error_log
        CustomLog /var/log/httpd/testapp-access_log common
        Options Indexes ExecCGI FollowSymLinks
        RewriteEngine On
    </VirtualHost>
{% endhighlight %}

## Step 6

You're done. You can now setup your web app. :) For more information on configuring your application to use fastcgi, please see the RailsWiki entry: [HowtoSetupApacheWithFastCGIAndRubyBindings][2]

## <a name="appendix1">Appendix 1</a></span>

This is a pkg_info dump from the server before the install process was started. You can use this as a reference on your system.

    apache-2.0.54 - Version 2 of Apache web server with prefork MPM.
    apr-nothr-db4-1.0.1_1 - The Apache Group's Portability Library
    bash-2.05b.007_2 - The GNU Bourne Again Shell
    bsdiff-4.2 - Generates and applies patches to binary files
    db42-4.2.52_4 - The Berkeley DB package, revision 4.2
    expat-1.95.8 - XML 1.0 parser written in C
    freebsd-update-1.6_1 - Fetches and installs binary updates to FreeBSD
    gettext-0.14.1 - GNU gettext package
    libiconv-1.9.2_1 - A character set conversion library
    mod_fastcgi-2.4.2 - A fast-cgi module for Apache
    mysql-client-4.1.11_1 - Multithreaded SQL database (client)
    mysql-server-4.1.11_1 - Multithreaded SQL database (server)
    neon-0.24.7 - An HTTP and WebDAV client library for Unix systems
    ngrep-1.43 - Network grep
    perl-5.8.6_2 - Practical Extraction and Report Language
    ruby-1.8.2_4 - An object-oriented interpreted scripting language
    ruby18-gems-0.8.11 - Package management framework for the Ruby language
    rubygem-actionmailer-1.0.1 - Easy email delivery and testing for Ruby
    rubygem-actionpack-1.9.1 - Action Controller and Action View of Rails MVC Framework
    rubygem-actionwebservice-0.8.1_1 - Simple support for publishing Web Service APIs for Rails ap
    rubygem-activerecord-1.11.1 - Object-relational mapping layer for Rails MVC Framework
    rubygem-activesupport-1.1.1 - Utility classes and extension that are required by Rails MV
    rubygem-rails-0.13.1 - MVC web application framework
    rubygem-rake-0.5.4 - Ruby Make
    subversion-1.1.4 - Version control system
    sudo-1.6.8.8 - Allow others to run commands as root
    vim-lite-6.3.62 - Vi 'workalike', with many additional features (Lite package)

 [1]: #appendix1
 [2]: http://wiki.rubyonrails.com/rails/show/HowtoSetupApacheWithFastCGIAndRubyBindings