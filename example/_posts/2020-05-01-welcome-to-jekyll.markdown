---
layout: post
title:  "Welcome to Jekyll shell prompt!"
date:   2020-05-01 10:25:45 +0200
---

This post shows by example how to use the shell block plugin.

The outcome of using the shell block should be look like this

<figure>
  <pre>
<samp>
  <span class="prompt">user@host:~$</span><kbd class="command">echo "Hello world!"</kbd>
  <span class="output">Hello world!</span>
</samp>
  </pre>
</figure>

Which is the rendering of the following

{% highlight html %}
<figure>
  <pre>
    <samp>
      <span class="prompt">user@host:~$</span><kbd class="command">echo "Hello world!"</kbd>
      <span class="output">Hello world!</span>
    </samp>
  </pre>
</figure>
{% endhighlight %}

To generate the previous nice shell rendering you can use the
`shell` block in your liquid templates.

{% highlight liquid %}
{% raw %}
{% shell %}
> echo "Hello world!"
Hello world!
{% endshell %}
{% endraw %}
{% endhighlight %}

And here is the final result

{% shell %}
> echo "Hello world!"
Hello world!
{% endshell %}

You can also pick parts of the result by using the `prompt`, `command`, `out` and `err` as tags.

#### example

To output html for a very minimal interaction
you can  use the tags directly

{% highlight liquid %}
{% raw %}
{% prompt user@host:~$ %}{% command echo "Hello World!" %}
{% out Hello World! %}
{% endraw %}
{% endhighlight %}

This is the resulting html

{% highlight html %}
{% prompt user@host:~$ %}{% command echo "Hello World!" %}
{% out Hello World! %}
{% endhighlight %}

<pre>
{% prompt user@host:~$ %}{% command echo "Hello World!" %}
{% out Hello World! %}
</pre>

#### prompt

{% raw %}
{% prompt root@host:~# %}
{% endraw %}

Will render as {% prompt root@host:~# %}

#### command

{% raw %}
{% command echo "Hello World!" %}
{% endraw %}

Will render as {% command echo "Hello World!" %}

#### out

{% raw %}
{% out Hello World! %}
{% endraw %}

Will render as {% out Hello World! %}

#### err

{% raw %}
{% err File not found %}
{% endraw %}

Will render as {% err File not found %}
