---
title: pragmatic unit testing with go
kind: article
created_at: 2013-09-08 21:02:00
author: fredrik
tags: golang, reusability, coding, programming, tdd, testing
---

[<img style="float:right" src="http://farm9.staticflickr.com/8373/8461414333_4a30e15dd3_m.jpg" />](http://www.flickr.com/photos/ajstarks/8461414333)

I am fortunate to code some [go](http://golang.org/) at my new assignment. I had some two weeks with the language last fall but apart from that it is new unmarked land for me. It is a nice language that is easy to learn and does things in very different ways. You get started really fast but with that nagging feeling that there is much more to learn around the corner. I suspect that you can be really productive in go. If you like your strong types and a bit lower level than normal you will get back performance only matched by C and a robust piece of code. 

Needless to say - the benefits of unit tests in a strongly typed and opionionated language like go is a bit lower than in dynamic languages like ruby, python and javascript. It is still necessary to keep your code base stable over time. So I have tried it out a bit. I started with the [standard library approach](http://golang.org/pkg/testing/) where you get something like this:

    func TestSomething(t *testing.T) {
      something := false
      if something {
        t.Log("Oh noes - something is false")
        t.Fail()      
      }
    }

Oh no. This is a bit verbose for my taste. Some four lines to do an assert.... Sure, you can add some semicolons and get in one line but with reduced readability. I sort of hoped that I had gotten something wrong here. This couldn't possible be the way to do it? I [turned to stackoverflow and asked how](http://stackoverflow.com/q/18637912/135673) to do it. The first two answers pretty much confirmed that this is the way to do it. Idiomatic go according to the language constructors. One of the answers stated that:

> I discourage writing test in the way you seem to have desire for. 
> It's not by chance that the whole stdlib uses the, as you call it, 
> "verbose" way.

I elaborated my question and asked if it wouldn't be nice to reuse a bit of code in my own assert method:

    func AssertTrue(t *testing.T, value bool, message string) {
      if value {
        t.Log(message)
        t.Fail()
      }
    }

and use it in my test like so:

    func TestSomething(t *testing.T) {
      something := false
      AssertTrue(t, something, "Oh noes - something is false")
    }

and I got this reply:

> Based on your update, that is not idiomatic Go. What you are doing is in 
> essence designing a test extension framework to mirror what you get in 
> the XUnit frameworks. While there is nothing fundamentally wrong, from 
> an engineering perspective, it does raise questions as to the value + cost 
> of maintaining this extension library. Additionally, you are creating an 
> in-house standard that will potentially ruffle feathers. The biggest thing 
> about Go is it is not C or Java or C++ or Python and things should be done 
> the way the language is constructed. 

So from this reasoning it seems like normal practices like code reuse is not applicable to go. Weird - me thinks.... So I started to give up hope about this nice little language. Fortunately a third answer (that I accepted) dropped in introducing gocheck and basically telling me that there are other opinions in the go community than the stdlib ones. Good to hear - maybe there is a place for a pragmatic programmer after all. With [gocheck](http://labix.org/gocheck) you can do asserts easily:

    func (s *MySuite) TestSomething(c *C) { 
      something := false
      c.Check(something, Equals, true, "Oh noes - something is false") 
    }

Works for me. I'm gonna use that for a while and see how it feels. I will - however - try to grasp the *go way* as I go and if needed will change my mind in this matter.

Expect more posts about go during the fall.
