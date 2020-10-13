---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Setting up a Facebook Pixel on Qualtrics"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2020-10-13T12:09:59-04:00
lastmod: 2020-10-13T12:09:59-04:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---


  ## 1. CREATING A FACEBOOK PIXEL
  
  - This is pretty straightforward. Go to the [Events Manager](https://www.facebook.com/events_manager2/list/pixel/3271211936235421/overview?act=243922916906371) and follow these simple [instructions](https://www.facebook.com/business/help/952192354843755?id=1205376682832142) to generate the pixel: _Events Manager_ > _Connect a New Data Source_ > _Web_ 
  
  - To add the pixel to your Qualtrics survey, you want to click "Install code manually."
  
  - Copy the base code, which looks something like the following inside ``<script>`` tags:
  
  ```js
!function(f,b,e,v,n,t,s)
{...}(window, document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', 'id');
fbq('track', 'PageView');
```

  ## 2. CONNECTING TO QUALTRICS SURVEY
  
  - Moving over to Qualtrics, navigate to the __General__ tab of your survey's __Look and Feel__, and paste the base code you just copied to the __Header__ (using the editor's HTML view).

  
  - Save and Publish!
  
  
  ## 3. TESTING YOUR PIXEL
  
  - Download the Chrome extension, [Facebook Pixel Helper](https://chrome.google.com/webstore/detail/facebook-pixel-helper/fdgfkebogiimcoedlicjlajpkdmockpc?hl=en), to see if your pixel is firing properly. 
  
  - Enter your survey through its Anonymous Link and activate the Facebook Pixel Helper. _Make sure that you have your adblocker turned off._
  
  - You can also see if your pixel is active by pasting the Anonymous Link to _Test Browser Events_ under the Test Events tab in your Events Manager.
  
  
  ### Done!
  
  #### By default, the base code provided by Facebook tracks only *Page Views*, but [here](https://developers.facebook.com/docs/facebook-pixel/implementation/conversion-tracking) are a bunch of other events you can track.
  
