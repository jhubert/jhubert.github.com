---
layout: post
title: Using attachment_fu from script console
category: article
tags: howto rubyonrails
---

I recently had to migrate a whole bunch of photos from one app to another, and since I&#8217;m using AttachmentFu for the image attachments I just opened up script/console so do the dirty work.

However, the dirty work didn&#8217;t work.

With FileColumn, I could just go  object.filename = &#8220;directory/#{filename}&#8221;, but that didn&#8217;t seem to do the trick with AttachmentFu. I needed to provide size and content_type.

I added an extension to the File class called content_type:

{% highlight ruby %}
class File
  # your expected mime types here
  FILE_EXTENSION_MIME_TYPES = {
    'jpg'  => 'image/jpeg',
    'png' => 'image/png',
    'gif' => 'image/gif'
  }
  def content_type
    FILE_EXTENSION_MIME_TYPES[File.extname(self.path).downcase.gsub(/^\./,'')] || 'application/octet-stream'
  end
end
{% endhighlight %}

and then had to use this call to create the new attachment_fu object:

{% highlight ruby %}
f = File.open(file)

Photo.create(
   :temp_data => IO.read(file),
   :content_type => f.content_type,
   :filename => file.split('/').last
)
{% endhighlight %}

and now in action:

{% highlight ruby %}
Property.find(:all).each do |p|
  next if p.photos.length > 0
  default = true
  Dir.glob("ap/#{p.internal_code}/*").each do |f|
    file = File.open(f)
    PropertyPhoto.create(:property_id => p.id, :temp_data => IO.read(f), :content_type => file.content_type, :filename => f.split('/').last, :default => default)
    default = false
  end;nil
end;nil
{% endhighlight %}

Hope that helps a few of you figure it out faster than I did.
