---
title: "Serving up that readme with grails"
kind: article
created_at: 2014-11-20
author: fredrik
tags: grails, markdown, readme
---

So you wrote a nice readme for your grails project and realized that it would be nice to serve it at some or other URL on your site. Yeah - happened to me too. So here is what I did.

First we need to add markdown capabilities to our grails project. For that we use the [markdown plugin](https://grails.org/plugin/markdown). Put the following line in your `BuildConfig.groovy`:

    compile ":markdown:1.1.1"

Next - [which may be tricky](https://stackoverflow.com/questions/12835568/using-markdown-as-a-grails-view) - we need to have the markdown file in our `views` directory for grails to find them. The file also need to end with `gsp`. The easiest way to accomplish this is to make a soft link (yes - git preserves soft links..... given your coworkers also is on some kind of unix):

    cd grails-app/views/readme
    ln -s ../../../readme.md readme.gsp

Then we need some kind of route. I decide to go for a `readme` path with its own controller but this can be done in several ways. Put this in your `UrlMappings.groovy`:

    "/readme"(controller:"readme")

and with that goes a `ReadmeController`: 

    class ReadmeController {
      def readme() {
        render(layout: 'markdown', view: 'readme')
      }
    }

We pass the view to `render` and also a special layout needed to trigger markdown. Here is the essential part of the layout:

    <body>
        <markdown:renderHtml>
            <g:layoutBody/>
        </markdown:renderHtml>
    </body>

And there you go with a nice path to your readme.

This is admittedly a bit cumbersome but pretty straightforward. The other approach is to read the markdown programmatically and do the markup processing in a controller. Probably pros and cons with both approaches.

(On a side note. At times like this I miss Ruby. I did [pretty much the same thing](https://github.com/froderik/anyrest/blob/master/anyrest.rb) with [sinatra](http://www.sinatrarb.com/) a while ago. Add a gem and 

    get '/' do
        markdown :README
    end

in the "controller". Much easier.)