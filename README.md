![Hammer Mario!](http://i.imgur.com/HUuvF.png)

**Hammer.vim**  
Hammer.vim translates a bunch of markup languages you're working on in vim to HTML, and then opens that HTML in your browser.  
By default, the preview is a clone of how GitHub would render _README.md_, but templates are supported too.  
This project was formerly _vim-markdown-preview_.

Supported Markup
----------------

Anything _github-markup_ supports:  

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
* .1 - Requires [`groff`](http://www.gnu.org/software/groff/)

Install 
--------
You might need to install an extra dependency depending on the markup language you want to render (See Above).  
Ruby vim support is required, too!

    gem install github-markup
    git clone git://github.com/robgleeson/hammer.vim.git
    cp -R hammer.vim/plugin $HOME/.vim/plugin


Usage
------

The `:Hammer` command will try to draw a preview of whatever file is currently in your buffer.  
It helps to map it to a key though, and I personally use: `map <leader>p :Hammer<CR>`

There are a few options, too:  

* g:HammerTemplate  
  The template to render with. Default is `default`, a GitHub-esque design.

* g:HammerDirectory  
  Where previews are written to. Default is `/tmp`

* g:HammerBrowser  
  The template to open the preview with. Default is OS-dependent.  
  `open` on OSX, `start` on Windows, and `xdg-open` on xorg-running machines.



Templates!
----------

If you don't like the default template, you can write your own.  
Check out the [default template](https://github.com/robgleeson/vim-markdown-preview/blob/develop/plugin/hammer.vim/templates/default.erb.html)
for ideas on how it's done.  
It's basically an erb template, with the markup transformed to HTML passed as a partial.  

Pull requests for new templates would be awesome ;-)

Screenshots
-----------

* [POD](http://d.pr/16YG)
* [Markdown](http://d.pr/GEuT)

Thanks
------

Many thanks to the @github team for _github-markup_!
