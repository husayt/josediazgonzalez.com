---
  title: Full Stack CakePHP Deployment With Chef and Capistrano - Part 3
  category: Deployment
  tags:
    - deployment
    - chef
    - cakephp
  layout: post
  description: Templating, Custom Resources, and Cookbook creation for the Chef Deployment Tool
  published: false
---

{% blockquote %}
This text is the third in a long series to correct an extremely disastrous talk at CakeFest 2011. It will also hopefully apply to more than CakePHP.
{% endblockquote %}

# Templates

Templating in Chef is much like templating in any other framework. Chef templates use ERB - eRuby - which is a templating system that embeds Ruby into a document. If you know any Ruby, this should be a fairly trivial thing to learn. For CakePHP developers, think `ctp` files :)

For PHP developers, the big difference is that it uses short-syntax - `<? ?>` - and the question marks are replaced with percent signs - `<% %>`. Along with the short syntax, there isn't an `echo` statement, so if you want to `echo` a variable, `<%= var %>` will do it.

Another key change is in variable output within strings. In PHP, we can do:

    $foo = 'bar';
    $baz = "{$foo}";
    echo $baz; // outputs: bar

In Ruby, we might do the following:

    foo = 'bar'
    baz = "#{foo}"
    puts baz # outputs: bar

That's pretty neat I think, not that big of a change.

Templates alone aren't very useful, but they are normally used in conjunction with the `Template` resource in Chef as follows:

{% highlight ruby %}
template "/path/to/where/template/should/be/written/to" do
  source "some_template.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :var_name   => "value"
    :an_array   => [ "of", "values" ]
  )
end
{% endhighlight %}

In the above example, we are creating the file `/path/to/where/template/should/be/written/to` from the `some_template.erb` file. We're also setting the owner, group and the permissions of the file. The variables `var_name` and `an_array` would be available as variables in the view.

Pretty straight-forward I think.

# Attributes

Attributes are fairly straight-forward. They allow you to set defaults for a particular cookbook by setting/modifying the variables in your `DNA` config.

{% highlight default.rb %}
# Deploy settings
default[:server][:production][:dir] = "/apps/production"
default[:server][:production][:hostname] = "example.com"
default[:server][:staging][:dir] = "/apps/staging"
default[:server][:staging][:hostname] = "example.net"

if node.nginx.attribute?("varnish")
  # ... do stuff on NGINX varnish stuff
end

override[:server][:extensions][:gzip] = true
{% endhighlight %}

In the above, we are setting the default `paths` and `hostnames` for the `production` and `staging` server environments, as well as setting some `varnish`-related configuration if `node[:nginx][:varnish]` exists; We also override the configured server extensions to ensure `gzip` will always be turned on, in case someone tries to turn it off via the `DNA` configuration.

I normally just set defaults and forget about it. For those deploying across multiple Operating Systems, we can do the following to set variables depending upon the OS:

{% highlight default.rb %}
# Platform specific settings
case platform
when "redhat","centos","fedora","suse"
  # Some settings here
when "debian","ubuntu"
  # Debian-related configuration
when "windows"
  # Windows-specific defaults
else
  # When all else fails...
end
{% endhighlight %}

Attributes are a good way of providing simple, cross-platform compatible defaults that can be later tweaked by way of `DNA` files. They allow you to provide a baseline configuration that might be modified in cases where we have more memory, lower disk throughput, or some other deviation from the norm.

If you find that you're constantly setting the same settings in your `DNA` file, feel free to modify the defaults to keep your setups DRY.

# Custom Resources

# Dependency Management

# Cookbook Creation

# Recap

We now have a pretty awesome `nginx_up` resource that can be used across multiple cookbooks. We could go further and make an abstracted `server_up` resource, but I'm pretty happy with our progress for now.

So what's next? Well, we have yet to deploy an entire server, and there is still the matter of what a `DNA` file actually is. As well, it would be useful to know how to actually push all of these files onto the server, and maintain the server as we move ahead. So the next post will cover the following:

- `DNA` files, how do they work?
- Syncing cookbooks and server dna to machines
- Actual machine deployment


**To Be Continued**