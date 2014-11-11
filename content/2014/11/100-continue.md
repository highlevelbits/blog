---
title: "Posting large files over SSL"
kind: article
created_at: 2014-11-11
author: fredrik
tags: java, apache, ssl
---

When posting a file in a complex setup with several layers I encountered a problem in a Java->Apache interaction. I got this error message:

    [Tue Nov 11 14:55:57 2014] [error] [client <ip>] request body exceeds maximum size (131072) for SSL buffer, referer: <referrer-url>
    [Tue Nov 11 14:55:57 2014] [error] [client <ip>] could not buffer message body to allow SSL renegotiation to proceed, referer: <referrer-url>

After some googling where [this stackoverflow post](https://stackoverflow.com/questions/14281628/ssl-renegotiation-with-client-certificate-causes-server-buffer-overflow) proved the most informative I learned that the upper limit for file size over SSL is rather low - just some 131702 bytes. The post lists several ways of solving the problem. I thought the header way was the neatest. I just added the header `Expect: 100-continue` to the call and the problem disappeared. The value of the header is rather cryptic but well documented in [the specs](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.20). Basically it tells the server to finish SSL negotiations before downloading the full request body from the client.
