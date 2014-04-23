---
title: "Making symbols available for AsciiDoc syntax in Sublime Text 3"
kind: article
created_at: 2014-04-23
author: hardy
tags: sublime, asciidoc
---

[Sublime Text](http://www.sublimetext.com/) has become my favorite editor on Mac. It is fast, flexible,
has tons of useful plugins and I can open any file or directory from the command line using *subl*.
There are many blog post out there describing the strength of Sublime, so today I just wanted
to focus on a problem for which I could not find a solution out of the box.

Sublime has become my default editor for Markdown and AsciiDoc. Whereas the symbol navigation via
*\<ctrl+r\>* works just fine for the Markdown plugin, it is not working for AsciiDoc. This is
especially painful when editing long documents where the symbol list gives a fast overview over the
file. In fact the missing symbols were nagging me so much, that I decided to embark into a discovery
journey into the inner workings of Sublime Text.

In Sublime Text 3 language support (syntax highlighting, snippets, etc) is bundled in a file with the
postfix *sublime-package*. Effectively it is just a zip file which you can expand to view its contents.
The main file is <Language>.tmLanguage. It contains a whole bunch of regular expressions which capture
and name different parts of the syntax of the language in question. To make symbols work you also need
a file called *Symbol List.tmPreferences* (the name is not relevant I think), which tells Sublime
which of the named syntax parts should be made available via symbols. Exactly this symbol list is missing
in the AsciiDoc plugin (http://github.com/SublimeText/AsciiDoc). After looking at *AsciiDoc.tmLanguage*,
I thought the following should work:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
       <key>name</key>
       <string>Symbol List</string>
       <key>scope</key>
       <string>markup.heading.asciidoc</string>
       <key>settings</key>
       <dict>
          <key>showInSymbolList</key>
          <string>1</string>
       </dict>
       <key>uuid</key>
       <string>954ecd40-ca54-11e3-9c1a-0800200c9a66</string>
    </dict>
    </plist>

*markup.heading.asciidoc* is one of the named elements from the tmLanguage file matching a heading line
(including the '=' signs). That was good enough for me.

The remaining question was, how to add this symbol list to the existing AsciiDoc sublime-package?
Did I have to re-package the zip? Turns out I don't have to.
Zipped packages are installed under

    ~/Library/Application Support/Sublime Text 3/Installed Packages/\<Package Name\>*

To override a file in any of these zip files or add a new file, create

    ~/Library/Application Support/Sublime Text 3/Packages/\<Package Name\>

and place your file in there.
In case of AsciiDoc this means

    ~/Library/Application Support/Sublime Text 3/Packages/AsciiDoc/Symbol List.tmPreferences

This is all very well explained [here](http://www.sublimetext.com/docs/3/packages.html).

Enjoy!