---
layout: post
title: Debugging your Ruby on Rails App
category: article
tags: howto rubyonrails
---

## Debugging your Ruby on Rails App

I gave a very quick and dirty presentation tonight at the [Vancouver Ruby Brigade][1] meeting. Here are my notes from that talk.

There are a bunch of great tools that help you debug your application in Rails. Here is a quick runthrough.

## In A View

{% highlight erb %}

    <%= debug @object %>
    or
    <%= debug 'string' %>
    or
    <%= 'string'.inspect %>

{% endhighlight %}

This will output the data directly on to the page. It's very useful for taking a look at what you're working with in the view, or to check if the variable contains any data at all. I use it all the time when I'm throwing up the Show views. I just dump out the object using debug and then use the data to build my layout.

## In A Controller

{% highlight ruby %}

    logger.debug "The object is #{@object}"

    RAILS_DEFAULT_LOGGER.debug @object

{% endhighlight %}

Both of these methods will print the the standard logger. The logger.debug method works within your application. The <span class="caps">RAILS_DEFAULT_LOGGER</span> will work inside the Rails framework (if you dare dive into it) or inside any libraries where logger is not defined.

{% highlight ruby %}
      return render :text => "The object is #{@object}"
{% endhighlight %}


The render :text call will dump the text to the screen and halt execution of the current action. This will allow you to see what you're working with right away, without having to pass variables to a view. It's great for quick debugging.

## In A Model

Using the <span class="caps">RAILS</span>\_DEFAULT\_LOGGER and logger.debug is one of your best options, if not the only one. If you're running [Mongrel][2] there are some great debugging tools, but I'm not going to go into them now.

## Outside The App Folder

### script/console

The console is an interactive ruby environment (irb) that has your entire application loaded up into it. You can try different things with your modules, check for dependencies or do maintenance. There are plenty of resources online for script/console tutorials. Have a look at this one to get started: [Robby On Rails talks about script/console][3]

To run console, just open terminal (or whatever prompt you have) and run script/console from the application root.

### tail

[Unix tail][4] , Ahh, I love tail. [tail][4] is a little unix app that will show you the end of a file... and if you use the -f option, it will 'follow' the end, which keeps showing you the end of the file even if it changes.

from the application root:

{% highlight bash %}
    tail -f log/development.log
{% endhighlight %}

Using this, you can keep an eye on what your applicaiton is doing the whole time. Generally, when I'm developing, I am constantly tailing my development log. Just makes it easy for me.

### script/breakpointer

Breakpointer is really straightforward, but for some reason it seems really complex. All you need to do is run script/breakpointer from your appplication root and then put the word 'breakpoint' anywhere in your app. When you're running your app and it hits the 'breakpoint', the breakpointer will pick it up and give you an Ruby console to work with. It works the same was as console, but from the current state of your application.

For more information on breakpointer, have a look at [HowtoDebugWithBreakpoint][5]

Note: breakpointer has been deprecated (Rails [Changeset 6611][6]). Use [Ruby Debug][7].

### script/server

If you're running using Locomotive or .. umm, whatever the windows version is (InstantRails) sometimes you get startup errors and can't see what they are because they're enclosed in the launch application.

All you need to do is open up your terminal and type script/server, which will launch your app in webrick or mongrel. if there are any dependencies, it will spit them out and let you know why it can't startup.

## In Production

Install the [ExceptionNotification][8] plugin. It's wonderful. Really. It will e-mail you if the application throws any error messages.

{% highlight bash %}
    script/plugin install http://dev.rubyonrails.org/svn/rails/plugins/exception_notification/
{% endhighlight %}



## Just Talk About It

If you're really stuck on a problem, the best thing to do is to talk to someone (or something) about it. Apparently, the part of your brain that tries to figure out the problem is different than the part of your brain that tries to describe the problem... so just trying to figure out how to explain the problem often shows you what's wrong and helps you fix it. Even if you just have a plant, pet or robot on your desk to talk to... it's ok, they're listening.

Other than that, good luck... and if you're in Vancouver on the second tuesday of every month, come to a Brigade Meeting. :)

 [1]: http://vancouver.rubybrigade.com
 [2]: http://mongrel.rubyforge.org/
 [3]: http://www.robbyonrails.com/articles/2005/08/18/are-you-a-console-master
 [4]: http://en.wikipedia.org/wiki/Tail_(Unix)
 [5]: http://wiki.rubyonrails.org/rails/pages/HowtoDebugWithBreakpoint
 [6]: http://dev.rubyonrails.org/changeset/6611
 [7]: http://wiki.rubyonrails.org/rails/pages/HowtoDebugWithRubyDebug
 [8]: http://dev.rubyonrails.org/svn/rails/plugins/exception_notification/
