---
title: go templating - the basics
kind: article
created_at: 2013-09-28 13:02:00
author: fredrik
tags: golang, coding, web, template engine
---

[<img style="float:right" src="http://farm3.staticflickr.com/2723/4264734398_f89371801a.jpg" />](http://www.flickr.com/photos/29363671@N08/4264734398)

I am busy coding a web site with [go](http://golang.org/). I am still not convinced that go is the best choice for web development unless performance is in high demand. It is still great fun to learn a new language and a language that have different opinions on many things compared to other languages. This kind of experiences are very good to move forward as a developer. So kudos to [flatwallet](http://www.flatwallet.se/) that lets me learn go while getting paid for it. 

We try to use as much as possible of the standard library but sometimes it is hard as I [described in my post about testing](http://highlevelbits.com/2013/09/pragmatic_unit_testing_with_go.html). When it comes to web development there is a good enough [template engine](http://golang.org/pkg/text/template/) that provides with the simplest things to get stuff into your [markup](http://highlevelbits.com/2012/04/control-your-markup.html). In mainstream template engines the normal way to get behavior into your template is to use `<% %>` for executing some code and `<%= %>` for getting some stuff inserted into the generated markup. In go you use double curly braces instead. So in order to insert a value you go `{{.Value}}`. The single point is a reference to the data structure (remember - no objects in go) that was passed to the template from the back end code and value is a field in that structure. There is the basic control flow things like:

    {{ if .IsActive }}
      Active
    {{ else }}
      Inactive
    {{ end }}

and loops:

    {{ range .Books }}
      <div>
        {{ .Title }} by {{ .Author }}
      </div>
    {{ end }}

When using `range` the `.` context is set to the current item for each loop over the collection. As you see you just mix curly braces with HTML freely. (So that it looks really messy to the eye....) Since the templating doesn't conflict with the markup you can also use them in attribute values. This may look nasty at times:

    <div class="{{if .IsActive}}active{{else}}passive{{end}}"/>

Not to my liking. The alternative is to add another field to the page structure and calculate the value in the go code instead. It adds a bit of duplication and the number of line increases and I am not sure the overall readability goes up. So the above may actually be a good choice at times. In this particular case it has the benefit of keepin css classes in the markup. Indeed - you could do it like this just as well:

    {{ if .IsActive }}
      <div class="active"/>
    {{ else }}
      <div class="passive"/>
    {{ end }}

Better or worse? This is a simple div with nothing else in it but consider a real world situation where there are some content inside etc. Then it may be better to go with the compact solution instead. Things like these may be good to put in the coding guidelines for a project. (You all do them - right?!?)

You can define a template with `{{ define "my_template" }} <html>....</html> {{ end }}` for both whole pages and parts in a page. Say you define a header partial: `{{ define "header" }}<div>Menus and other header stuffs.</div>{{ end }}` then you can use it in another template with: `{{ template "header" }}`. So that is kind of neat. There is no support for layouts so for solving that in the standard library way you'll have to do it yourself with functions calling different templates in different contexts. 

One more thing. You can use `with` to get deeper in the context of the page. Like this:

    {{ range .Books }}
      <div>
        {{ .Title }} by 
        {{ with .Author }}
          {{ .FirstName }}{{ .LastName }}
        {{ end }}
      </div>
    {{ end }}

I haven't used this much but it has the benefit of getting evaluated only if there is something in the referenced value. So it is a combined `if` statement with a scope narrower.

Then there is a bunch of built-in functions that makes life a bit easier. The one that has bothered me most is `call` that lets you call a function from within the template. But not any function. It must either have been previously tied to the template with calls to `Funcs` with a `FuncMap` or be in the global namespace. So if you have a nice little function tied to the struct you are exposing to your template you can not use it right away. I find this limiting - the extra code to set it up can just as well be used to introduce another variable in the struct that holds the computed value. You end up with redundant data in your model where parts are 'real' data and parts are computed values. I don't have a perfect *feel* for this yet and will come back to review it later and maybe another post about advanced templating.

The standard library documentation is really good. The templating basics is in the [text/template package](http://golang.org/pkg/text/template/) while there are some added things for web pages in the [html/template package](http://golang.org/pkg/text/template/). This separation is obviously good so that you can do templating inside whatever format you work with.

Engine photo by [Jon Pekelnicky](http://www.flickr.com/photos/29363671@N08/).
