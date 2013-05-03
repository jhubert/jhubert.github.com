---
layout: post
title: Using Globalize without changing your resource links
last_updated: 2007-10-08
category: article
tags: howto rubyonrails
---

## Using Globalize without changing your resource links

NOTE: This page was created in order to get ideas going, and thankfully it did just that. Please have a look at [Sven's more elegant solution.][1]

One of the projects I'm working on needs to have internationalization, so almost exactly after seeing [Jeremy Voorhis][2] talk about [Globalize][3] at Canada on Rails, I have finally installed it and taken a look around.

Despite some limitations, such as potentially large database tables if you have a lot of languages and the disabling of :through relationships, it's a very slick plugin. It's almost entirely invisible. You install it, add a line to each model that you want translated and you're pretty much good to go. Sits nicely right on top of your app.

Now, being the eccentric perfectionist I am, I would really like the locale to be in the <span class="caps">URL</span> so that:

*   people can bookmark their page and still have the correct language
*   search engines will find and parse multiple languages
*   people can send a link to their friend in the same language

After following [a wonderful Globalize tutorial][4] by Sven Fuchs my localized urls were setup in a matter of minutes, with only 1 caveat.

When using named routes and the resourceful helpers you just need to pass the locale in as the first parameter, like this:

{% highlight ruby %}
    article_path(@current_locale,@article)
{% endhighlight %}

Easy enough, right? Well.. not to me. Every application I build these days uses restful routes, and having to pass the current locale into each link on every page really removes the invisible nature of the Globalize plugin and seems like unnecessary meta data. I really want the app to know it's current_locale and behave accordingly, unless I want to change the locale. It should be:

{% highlight ruby %}
    article_path(@article)
{% endhighlight %}


Go ahead, call me picky. ;)

So off I go, digging into the Rails 1.2 Source Code looking for the magic that will make this all work well for me. Low and behold, I found it.. and wouldn't you know it, it was only one line that needed to be added to the define\_url\_helper method.

{% highlight erb %}
    #{'args << { :locale => @current_locale }' if segment_keys.include?(:locale)}
{% endhighlight %}

This line, when placed at row 78 of routing.rb prepends the current_locale to any route that has :locale defined as a key.

A few copy and pastes and some manual testing later, I have exactly what I want.

I have created a pastie for you to look over. It is very hackish right now, but I was just talking to Jeremy Voorhis. He said we might be able to clean it up and include it as an optional module in Globalize so that you don't have to include yet <span class="caps">ANOTHER</span> plugin in your app.

The Pastie: [Adding locale to your <span class="caps">URL</span> using Rails and Globalize][5]

Have a look. Give it a shot. Let me know what you think. :)

 [1]: http://www.artweb-design.de/2007/4/24/concise_and_transparently_localized_rails_url_helper_methods
 [2]: http://www.jvoorhis.com
 [3]: http://www.globalize-rails.org/globalize/
 [4]: http://www.artweb-design.de/2007/3/16/globalize-rails-routes-setup
 [5]: http://pastie.caboo.se/52246
