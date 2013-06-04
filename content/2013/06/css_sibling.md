---
title: css sibling operator (folding divs)
kind: article
created_at: 2013-06-05 01:00:00
author: fredrik
tags: css
---

I have been fiddling with CSS a lot in my current client project. I am no ninja yet but I am getting hold of the elementary stuff at least. Today I made one radio button show a div and another one hide it. To be able to do this you need to know about the sibling operator `~` that is used to find an element matching the selector that is *after* the main rule. Consider this markup snippet:

    <input checked="checked" class="fold_open" type="radio" value="open" />
    <input class="fold_closed" type="radio" value="closed" />
    <div class="foldee">
      <!-- some awesome markup here -->
    </div>

Two radio buttons with classes `fold_open` and `fold_closed` respectively. One div with the class `foldee`. To make the div fold when `fold_closed` selected and unfold when `fold_open` is selected - add this css:

    .fold_open:checked ~ .foldee {
      display: block;
    }

    .fold_closed:checked ~ .foldee {
      display: none;
    }

[<img src="http://farm4.staticflickr.com/3221/2844798054_37bc48f208_m.jpg" style="float:right" />](http://www.flickr.com/photos/henry-gail/2844798054)
This means that when the class `fold_open` is checked (works for radio buttons and check boxes) its sibling `foldee` will be shown and when `fold_closed` is checked it will disappear. A tricky thing with the sibling selector is that it only finds elements after its left hand operator. So if you want to hide something above you will have to rearrange your markup and use inspired styling to make it show up in the right place.

This will probably not work in *some* browsers mayhaps causing a problem depending on your use case and your user base. For a version that is guaranteed to work you will have to write some scripts instead. The amount of code with something like jquery is about the same. But I found it a bit more elegant to do it with css.

The car in the photo is an [Alfa Romeo 1900 CSS](http://en.wikipedia.org/wiki/Alfa_Romeo_1900) and it is just here for looks. Find a good photo about css..... It was shot by flickr user Henry Figueroa.
