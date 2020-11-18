---
draft: false
view: 2
header:
  caption: ""
  image: ""
title: Setting up a Facebook Pixel on Qualtrics
date: 2020-08-01T15:39:45.785Z
featured: true
tags:
  - surveys
image:
  filename: 0015917_facebook-pixel-by-nopcommerce-team.png
  preview_only: true
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
  
