---
title: "Cutting part of a large file with sed"
kind: article
created_at: 2016-04-04
author: fredrik
tags: sed
---

`sed` helped me again. I got this really large database backup file (14 GBs) and needed to extract the part involved in one 
of the tables. After finding the table in question on line 22372205 and deciding that the part I needed ended
on line 22708925 it was really easy to extract with sed:

    sed -n '22372205,22708925p' backup.sql > backup_part.sql

