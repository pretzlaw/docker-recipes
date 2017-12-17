echo '# WordPress PHP requirements'
echo '#'

docker_recipe php/curl
docker_recipe php/gd
docker_recipe php/xml
# There is no PHP7 support yet.
# docker_recipe php/xmlreader
docker_recipe php/zip

echo RUN docker-php-ext-install iconv
echo RUN docker-php-ext-install hash
echo RUN docker-php-ext-install json
echo RUN docker-php-ext-install mbstring
echo RUN docker-php-ext-install mysqli
echo RUN docker-php-ext-install simplexml
echo RUN docker-php-ext-install sockets
echo RUN docker-php-ext-install tokenizer

echo '#'
echo '#############'
