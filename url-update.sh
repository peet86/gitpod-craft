#!/bin/bash

echo "> Updating workspace preview urls.."

URL=`gp url`
URL="${URL/'https://'/'https://8000-'}" 

# site urls for dev environment
gp env SITE_URL="$URL"

eval $(gp env -e) 
