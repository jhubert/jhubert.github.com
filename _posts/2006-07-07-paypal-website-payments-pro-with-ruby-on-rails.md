---
layout: post
title: Using Paypal Website Payments Pro with Ruby On Rails
category: article
tags: howto rubyonrails
---

## Using Paypal Website Payments Pro with Ruby On Rails

There have been a few tutorials written on using [PayPal][1]'s API with RubyOnRails. There have been [plugins made][2] and [patches][3] to [ActiveMerchant][4] developed. Still, I could not for the life of me get it working for the longest time. This is my walkthrough.. it's the idiot's walkthrough. I assume nothing about your knowledge, and I will explain it in a detailed step by step process.

Here are the steps required to using PayPal's [Website Payments Pro][5]. Also note that at this time Website Payments Pro is <span class="caps">ONLY</span> available to US merchants.

1.  Get a [PayPal business or premier account][6].
2.  Apply for Website Payments Pro and get approved.
3.  Setup a [Paypal developer account][7] and sandbox accounts
4.  Get the necessary <span class="caps">API</span> access and certificates
5.  Download the [<span class="caps">ELC</span> RoR::Paypal Plugin][8]
6.  Download [soap4r][9] and [http-access2][10]
7.  Install the plugin
8.  Setup the plugin and certificates
9.  Run the tests

If you've already done most of this and you're just looking for answers to the hard questions, here they are for reference:

1.  You need to use the Nov 2005 version of soap4r to generate the wsdl and to send the request to paypal
2.  Your Username and Password for using the <span class="caps">API</span> is <span class="caps">NOT</span> your Paypal login info. It is the username and password provided for you when you generate the <span class="caps">API</span> Certificate.
3.  Paypal's Country Codes are the <span class="caps">TWO</span> character international standards. CA, US, DE, JP etc

Here are some common issues we hit and what they mean:

1.  "OrderTotal is required" - You are using an old version of the default.rb and defaultDriver.rb files. You need to regenerate them with the [Nov 2005 version of soap4r][9] (or newer).
2.  Authentication Error - Not using the right username / password from the <span class="caps">API</span> Credentials
3.  <span class="caps">SSL</span> Not Supported - You need to install [http-access2][10]

 [1]: http://www.paypal.com
 [2]: http://www.elctech.com/products_ruby_paypal.shtml
 [3]: http://home.leetsoft.com/am/ticket/4
 [4]: http://home.leetsoft.com/am
 [5]: https://www.paypal.com/IntegrationCenter/ic_pro_home.html
 [6]: https://www.paypal.com/cgi-bin/webscr?cmd=_registration-run
 [7]: https://developer.paypal.com/devscr?cmd=_signup-run
 [8]: http://www.elctech.com/ruby/ruby_paypal-1_4.tgz
 [9]: http://dev.ctor.org/download/archive/soap4r-20051117.tar.gz
 [10]: http://dev.ctor.org/download/archive/http-access_2_0.tar.gz