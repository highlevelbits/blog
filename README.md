high level bits repository
==========================

Introduction
------------

This is the repository of the blog that can be found at [highlevelbits.com](http://highlevelbits.com). The blog runs on a static site generator called [nanoc](http://nanoc.ws/). You can have a look in the [Gemfile](https://github.com/highlevelbits/blog/blob/master/Gemfile) to find out what dependencies we have.

To get started
--------------

    # get the repo
    git clone git@github.com:highlevelbits/blog.git
    cd highlevelbits/blog

    # set up the gh-pages branch
    git clone git@github.com:highlevelbits/blog.git output
    cd output
    git checkout gh-pages
    cd ..

    # install some gems
    bundle install

    # generate the site
    nanoc

    # start a local server
    nanoc view

    # publish the site
    ./publish.rb

Iterate the final 3 whenever content has changed.

File structure
--------------

Content can be found in the `content` directory structure. Directly in the content root lies a couple of pages that are shown at the top level. Most important is the start page (`index.haml`) and the archive (`archive.haml`). They are written in HAML. Folders named with years have all the posts sorted in sub folders for months. They correspond to the post url.

In the folder `layouts` are - meh - layouts. There are two layouts now. One for the overall look and one specific for posts.

In `lib` are some common code that is used to generate content. Functionality for tagging, feeds and the archive got helper methods here. Here more functionality can be added as need arises.

The `output` folder is where nanoc put the generated content. It should be a clone of the repository with the gh-pages branch checked out for the publishing to work. (Todo: push hook somewhere that publishes automatically so we don't need this weird branch setup.)

Finally in the root folder itself are a couple of files that configures nanoc. `Rules` decides how content are to be compiled and on what URLs they will appear. `config.yaml` is the nanoc configuration. `publish.sh` is a script that publishes the site. `Gemfile` contains the dependencies needed to run the thing.

File type support
-----------------

Currently content can be written in markdown, erb or haml. Check (or change) the [Rules](https://github.com/highlevelbits/blog/blob/master/Rules) file for the most up to date definitions. To add support for another markup engine should be as easy as adding a `when` to the `case` in the Rules `compile` part and adding the corresponding gem to the Gemfile. (Also - run `bundle install`.)

Posts
-----

All files that are articles have to have a nanoc header. Here is an example for posts:

    ---
    title: "Back in Javaland"
    kind: article
    created_at: 2014-03-05 07:00:00
    author: fredrik
    tags: java
    ---

The title makes it on to lists of posts. 

The kind decides how to process it in the Rules file - this typically affect what layout to use. At the moment there are `article`, `tag`  and default behaviour. Here we could add other types for special parts of the site.

The date decides where in the post list an entry will appear and is also shown in the post header.

Author is author.

Tags are a comma separated list of tags. They are listed on each post and also got their own page. Tags with only one article are not shown.

Contribute
----------

If you find errors in our content or want to contribute an article you can clone the repo and send us a pull request.
