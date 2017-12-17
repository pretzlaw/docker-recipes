#!/usr/bin/env bash

echo '# WordPress requirements'
echo '#'
echo '# see https://wordpress.stackexchange.com/questions/42098/what-are-php-extensions-and-libraries-wp-needs-and-or-uses'
echo '#'
echo ''

docker_recipe wordpress/php
docker_recipe wordpress/wp-cli
docker_recipe wordpress/latest

echo '#'
echo '# WordPress requirements done.'
