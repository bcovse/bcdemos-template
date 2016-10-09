# Demo Template
This repo contains template code for creating a demo site with dynamically loaded players.

### Usage
* Clone this repo to a local directory
* Run ./create-demo.sh (you may need to make it executable first) with the following flags (all are required):
  * -d - the local directory in which you want the demo site created (full path)
  * -r - the repository name to create for the new demo site. This will be prepended with "bcdemos" (foo will become
  bcdemos-foo)
  * -u - your GitHub username (you'll be prompted for your password)

### Requirements
* git
* cURL

### Additional Info
This template provides the following structure: 

```
- css
  |- bootstrap.min.css
  |- <sitename>.css
- img
- js
  |- bootstrap.min.js
- config.json
- index.html
```

The config.json file is used to popluate player and video information and contains some basic example. The remaining files
provide basic building blocks for creating a customized demo site.