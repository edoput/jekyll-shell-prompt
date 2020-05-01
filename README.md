# jekyll-shell-prompt

This gem is an experiment in putting more structured content when writing
a post that contains shell interactions.

## Installation

Add this line to your application's Gemfile:

```ruby
group :jekyll_plugins do
  gem 'jekyll-shell-prompt'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jekyll-shell-prompt

## Usage

This gem provide the following tags for you to experiment with `prompt`, `command`, `out` and `err`.

There is also a non working `shell` block to glue the tags together following a very simple
line protocol that looks at the first character of a line to decide what does it mean

```
> # for input lines that the user will type
< # for output lines that the shell will output to stdout
! # for output lines that the shell will output to stderr
```

In general as stdout is the one responsible for the more lines in an interaction
you can leave the `<` tag out and it will be formatted as stdout.

As an example

```
{% shell %}
> echo "Hello World!"
Hello World!
> echo "Hello World!" >&2
! Hello World!
{% endshell %}
```

You can find an example website that shows how to use each tag in the `example` folder.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/edoput/jekyll-shell-prompt.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
