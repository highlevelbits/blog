---
title: "Multiple unicorn servers with SSL on nginx"
kind: article
created_at: 2014-06-11
author: fredrik
tags: unicorn, ssl, nginx, devops, rails, sinatra, server
---

A while ago I set up my own [arch linux](https://www.archlinux.org/) server at [digital ocean](https://www.digitalocean.com/). It was some work and I learned a lot in the process. At the moment I have three [unicorn](http://unicorn.bogomips.org/)-based ruby things running behind [nginx](http://nginx.org/) on the server. One is built with [rails](http://rubyonrails.org/) and the other two with [sinatra](http://www.sinatrarb.com/). The one with rails is SSL-only. The work of setting up nginx was pretty straightforward but still I had to understand things from several sources so here is a rundown of how I accomplished this.

nginx is easy to configure. Compared with [apache](https://httpd.apache.org/) it is a breeze. The configuration is typically placed in `/etc/nginx/nginx.conf`. The syntax is basically:
    
    <key> {
        <key> <value>;
    }

And there can be nested blocks inside another block. When configuring a server it seems to me that the freedom about how to nest things is rather high as long as it makes sense to the configuration.

My server is defined inside a `http` block that contains all the domains I want to configure for the server. It then got some sensible defaults that I copied from somewhere:

    http {
        include       mime.types;
        default_type  application/octet-stream;

        ssl_session_cache builtin:1000 shared:SSL:10m;

        sendfile        on;
        tcp_nopush     on;

        keepalive_timeout  120;

        gzip  on;
        gzip_vary on;
        gzip_min_length 500;

        gzip_disable "MSIE [1-6]\.(?!.*SV1)";
        gzip_types text/plain text/xml text/css
           text/comma-separated-values
           text/javascript application/x-javascript
           application/atom+xml image/x-icon;

        ....
    }

As you can see this is some reasonable stuff that I want to have for all my domains. But it is not the focus of this post so you'll have to read up on it elsewhere. Then I configured the upstream unicorn connection for each domain like this:

    http {
        ....
        upstream oneofmydomains_unicorn_server {
            server unix:/var/rack/oneofmydomains/tmp/sockets/unicorn.sock
        }
        ....
    }

`oneofmydomains_unicorn_server` is just a name that will be used later to bind a domain to this unicorn socket. The file name coming after `unix:` should be the one in your unicorn config for that particular server.

Then comes a `server` section for each domain. Lets start with the plain HTTP variant:

    http {
        ....
        server {
            listen 80;
            server_name .oneofmydomains.com;

            location / {
                root /var/rack/oneofmydomains/public;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_pass http://oneofmydomains_unicorn_server;
            }
        }
    }

This section starts with the port to listen on this should be 80 in most cases. Then comes the server name describing what domain requests to listen to for this server. This is the part that makes it possible to have several domains running on the same nginx instance. After that another block called `location`. It starts with where to find static content. So for each request it will look for files in this folder and serving them - if none is found it will move on to the `proxy_pass` unicorn server that should match the name given in the upstream section above. The other `proxy_*` directives is needed to give the unicorn server a useful environment.

So onwards to SSL. One might think that here is where you put in a `https` section instead of `http` and there is such a construct. I didn't try it since I got it to work in another way. There are probably several ways to do this.

To enable SSL you need to get a certificate. If your site is serious you want to buy it from a trusted signatory but if you don't care about users getting warnings about untrusted certificates you can generate one yourself.

I used a variant of the server section to setup SSL. Like this:

    http {
        ....
        server {
            listen 443;
            server_name .oneofmydomains.com;

            ssl on;

            ssl_certificate     /etc/nginx/www.oneofmydomains.com.cert;
            ssl_certificate_key /etc/nginx/www.oneofmydomains.com.key;
            ssl_protocols        SSLv3 TLSv1 TLSv1.1 TLSv1.2;       # default on newer versions
            ssl_ciphers          ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES128-SHA:RC4-SHA:RC4-MD5:ECDHE-RSA-AES256-SHA:AES256-SHA:ECDHE-RSA-DES-CBC3-SHA:DES-CBC3-SHA:AES128-SHA;
            ssl_prefer_server_ciphers on;

            root /var/rack/oneofmydomains/public;

            location / {
                proxy_set_header Host $http_host;
                proxy_set_header X-FORWARDED-PROTO https;
                # pass to the upstream unicorn server mentioned above
                proxy_pass http://oneofmydomains_unicorn_server;
            }
        }
    }

As you can see most of the server section is the same. The default port for SSL is 443 so if you want your users to be able to use https://oneofmydomains.com without a port number - this is the way to go. (Just like 80 in the case of normal http.)

`ssl` is `on` and the certificate and its key is specified. Then there are lists of protocols and ciphers. This is used when a calling client handshakes with the server. It is just to decide a protocol and cipher to use for the interaction. If there is no match you may have a problem.... The location part is a bit different also with a somewhat different proxy header setup. 

And there you go. Once `nginx.conf` is edited you need to restart or reload nginx in order to make the changes effectual. I have enjoyed working with nginx. It is not so hard to understand what to do and the number of pitfalls are kept at a minimum.