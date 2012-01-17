__OVERVIEW__

| Project         | Hammer.vim 
|:----------------|:--------------------------------------------------
| Homepage        | https://github.com/robgleeson/hammer.vim
| Author          | Rob Gleeson

__DESCRITPION__

Hammer is a Vim plugin written in Ruby that can be used to render your favorite   
markup language to HTML for viewing in your browser of choice.    

It supports a large number of markup languages out of box but it also supports   
adding custom renderers for markup languages it does not support.

It has support for multiple different layout (with one styled like the GitHub   
README layout). You can use your favorite template language to draw up your own   
layouts (ERB, HAML, …). Layouts are passed the rendered HTML as a partial.

__SUPPORTED MARKUP__

* [.markdown](http://daringfireball.net/projects/markdown/) -- `gem install redcarpet`
* [.textile](http://www.textism.com/tools/textile/) -- `gem install RedCloth`
* [.rdoc](http://rdoc.sourceforge.net/)
* [.org](http://orgmode.org/) -- `gem install org-ruby`
* [.creole](http://wikicreole.org/) -- `gem install creole`
* [.mediawiki](http://www.mediawiki.org/wiki/Help:Formatting) -- `gem install wikicloth`
* [.rst](http://docutils.sourceforge.net/rst.html) -- `easy_install docutils`
* [.asciidoc](http://www.methods.co.nz/asciidoc/) -- `brew install asciidoc`
* [.pod](http://search.cpan.org/dist/perl/pod/perlpod.pod) -- `Pod::Simple::HTML`
  comes with Perl >= 5.10. Lower versions should install Pod::Simple from CPAN.
* .1 -- Requires [`groff`](http://www.gnu.org/software/groff/)
* .html
* .xhtml


__INSTALL__

You may need to install other dependencies for your markup language (See Above)  

    $ [sudo] gem install github-markup tilt albino
    $ [sudo] sudo easy_install pygments
    $ git clone git://github.com/robgleeson/hammer.vim.git
    $ cp -R hammer.vim/plugin/* $HOME/.vim/plugin

__RVM USERS__

If you use RVM, it may be the culprit of what appear to be random segmentation   
faults but they're not random and their cause is easily pin pointed.

RVM sets `$GEM_HOME` and `$GEM_PATH` to point at the gems for the currently   
selected RVM ruby, but Vim may not be built against the Ruby selected by RVM.  
If Vim were to be built against 1.8 and RVM pointed at gems for 1.9, you'll see   
Vim try to load 1.9 C extensions, which can end up causing segmentation faults   
in the worst possible scenario.

The solution proposed by Wayne Seguin(author of RVM) is to define 'vim' as a   
shell function that unsets `$GEM_HOME` and `$GEM_PATH` before the launch of Vim:

    mvim()
    {
      (unset GEM_PATH GEM_HOME; command mvim "$@")
    }


__SCREENSHOTS__

* [POD](http://d.pr/16YG)
* [Markdown](http://d.pr/GEuT)


__LICENSE__

See LICENSE.txt
