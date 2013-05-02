Project Description
===================
To create a fast and effective ROI/BEP sales tool for the HP Indigo and Inkjet Web Press sales teams to accelerate SOS (step of sales) velocity.

Infrastructure Requirements
===========================

Browser Compatibility
--------------------
At launch, the ST application should be compatible on the following market leading browser makes and versions:
*	Safari 6.0
*	Firefox 18
*	Chrome 24
*	Internet Explorer 9

Device Optimization
-------------------
The design should be approached for general use by all devices using the above browsers, with UI optimization choices weighted towards laptops and large tablet devices, such as the Apple iPad.

Development Environment Setup (Mac)
===================================
1.  brew install posgresql
2.  brew install imagemagick
3.  Clone the repo: git clone git@github.com:rogergraves/costingtool.git
4.  Install Ruby 2.0.0-p0
5.  Navigate to costingtool directory
6.  Install bundler gem
7.  Run "bundle install"
8.  rake db:create
9.  rake db:migrate
10. rake db:test:prepare
NOTE -- if you run into hstore error, try: psql -d template1 -c 'create extension hstore;'
