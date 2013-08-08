## Overview

| Project            | Hammer.vim
|------------------- |--------------------------------------------------
| Author             | [Matthias Günther](http://wikimatze.de "Matthias Günther")
| Former-Author      | [Rob Gleeson](https://github.com/robgleeson "Rob Gleeson")


## Description

Hammer is a Vim plugin written (mostly) in Ruby.  It can be used to transform your markup language of choice to HTML,
and open the transformed HTML in whatever your favorite browser is.

It supports a large number of markup languages out of box but it also supports adding custom renderers for markup
languages it does not support.

It has support for multiple different layouts (with one styled like the GitHub README layout). You can use your favorite
template language to draw up your own   layouts (ERB, HAML, …). Layouts are passed the rendered HTML as a partial.

People familiar with Ruby web development should feel right at home with the layout & partial style templates.


## Supported Markup
- [.markdown](http://daringfireball.net/projects/markdown/) -- `gem install redcarpet`
- [.textile](http://www.textism.com/tools/textile/) -- `gem install RedCloth`
- [.rdoc](http://rdoc.sourceforge.net/)
- [.org](http://orgmode.org/) -- `gem install org-ruby`
- [.creole](http://wikicreole.org/) -- `gem install creole`
- [.mediawiki](http://www.mediawiki.org/wiki/Help:Formatting) -- `gem install wikicloth`
- [.rst](http://docutils.sourceforge.net/rst.html) -- `easy_install docutils`
- [.asciidoc](http://www.methods.co.nz/asciidoc/) -- `brew install asciidoc`
- [.pod](http://search.cpan.org/dist/perl/pod/perlpod.pod) -- `Pod::Simple::HTML`
  comes with Perl >= 5.10. Lower versions should install Pod::Simple from CPAN.
- .1 -- Requires [`groff`](http://www.gnu.org/software/groff/)
- .html
- .xhtml


## Commands

The `:Hammer` command will transform your content to HTML, and open your
browser.


## Config Variables
- g:HAMMER\_DIRECTORY
  The path where transformed HTML files are kept.
  Defaults to `/tmp` on UNIX, and `$TEMP` on Windows.
- g:HAMMER\_BROWSER
  The path to a browser for viewing HTML files.
  Defaults to `open` on OSX, `start` on Windows, and `xdg-open` on X11 machines.
- g:HAMMER\_TEMPLATE
  The template to use.
  Defaults to 'default', a GitHub-esque README template.
- g:HAMMER\_BROWSER\_ARGS
  Optional arguments to pass to the `browser` command.  On OS X, it can be useful
  to set this to '-g' to open the browser window in the background.


## Install
You may need to install other dependencies for your markup language (See Above)

    $ [sudo] gem install github-markup tilt
    $ git clone git://github.com/matthias-guenther/hammer.vim.git
    $ cp -R hammer.vim/plugin/* $HOME/.vim/plugin


## Rvm Users

If you use RVM, it may be the culprit of what appear to be random segmentation faults but they're not random and their
cause is easily pin pointed.

RVM sets `$GEM_HOME` and `$GEM_PATH` to point at the gems for the currently selected RVM ruby, but Vim may not be built
against the Ruby selected by RVM.  If Vim were to be built against 1.8 and RVM pointed at gems for 1.9, you'll see Vim
try to load 1.9 C extensions, which can end up causing segmentation faults in the worst possible scenario.

The solution proposed by Wayne Seguin (author of RVM) is to define 'vim' as a shell function that unsets `$GEM_HOME` and
`$GEM_PATH` before the launch of Vim:


    mvim()
    {
      (unset GEM_PATH GEM_HOME; command mvim "$@")
    }
    
## rbenv users

Even if you have set a global ruby, Vim will use your system ruby, so make sure you install the gems above under this
path. You can switch to the system Ruby with:

    $ rbenv shell system
    
Then, run:

    $ [sudo] gem install github-markup tilt


## License

See LICENSE.txt

