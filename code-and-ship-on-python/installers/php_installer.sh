mkdir /home/websson/bin
curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar
mv phpbrew.phar /home/websson/bin/phpbrew

wget https://github.com/dunglas/frankenphp/releases/download/v1.2.4/frankenphp-linux-x86_64
chmod +x frankenphp-linux-x86_64
mv frankenphp-linux-x86_64 home/websson/bin/frankenphp

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /home/websson/bin/wp

wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
chmod +x phpcs.phar
mv phpcs.phar /home/websson/bin/phpcs

wget https://drive.google.com/file/d/1WHrRdLzvnsTRRlKcpBzBlT0WKO0VRfx7/view?usp=sharing
mv phpbrew7and8.tar.gz /home/websson && cd /home/websson/ && tar -xvzf phpbrew7and8.tar.gz
rm /home/websson/phpbrew7and8.tar.gz

echo "PHP Brew and tools installed"
echo "SET /home/websson/bin to PATH for this session or log back in again" 
echo "export set PATH=$PATH:/home/websson/bin" >>  /home/websson/.bashrc
