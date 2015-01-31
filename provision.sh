# General Tools
apt-get update
apt-get install -y curl libcurl3 gthumb trash-cli zsh
apt-get install -y mlocate && updatedb

# Apache and PHP
apt-get install -y apache2 libapache2-mod-php5 php-pear php5-xsl php5-gd php5-curl php5-json php5-cli php5-curl php5-mcrypt php5-gd vim
a2enmod rewrite
cp /var/sites/vagrant/files/vagrant.vhost /etc/apache2/sites-available/
a2ensite vagrant.vhost
a2dissite 000-default
service apache2 restart

# python
apt-get install -y python-software-properties build-essential libssl-dev
#node
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs
npm install -g grunt-cli
npm install -g yo

# Programming tools
pear channel-update pear.php.net
pear upgrade-all

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Git
apt-get install -y git-core
git config --global color.branch auto
git config --global color.diff auto
git config --global color.status auto
git config --global user.name "ruizfrontend"              # nombre de usuario
git config --global user.email ruizfrontend@gmail.com     # Email
git config --global alias.st status
git config --global alias.duff 'diff --cached'
cat /var/sites/vagrant/files/git-show-branch.txt >> $HOME/.bashrc

# PECL & extensions
apt-get install  -y php5-dev colordiff gettext graphviz
pecl install uploadprogress
echo 'extension=uploadprogress.so' >> /etc/php5/apache2/php.ini
service apache2 restart

# PHP custom configuration
sed -i 's/memory_limit = 128/memory_limit = 256/' /etc/php5/apache2/php.ini
sed -i 's/memory_limit = 128/memory_limit = 0/' /etc/php5/cli/php.ini
sed -i 's/error_reporting = Off/error_reporting = On/' /etc/php5/apache2/php.ini
sed -i 's/error_reporting = Off/error_reporting = On/' /etc/php5/cli/php.ini
sed -i 's/display_errors = Off/display_errors = On/' /etc/php5/apache2/php.ini
sed -i 's/display_errors = Off/display_errors = On/' /etc/php5/cli/php.ini

# Compass
#curl -L https://get.rvm.io | bash -s stable
#source ~/.rvm/scripts/rvm
#rvm install ruby
#rvm use ruby --default
#rvm rubygems current
gem install sass
gem install compass
gem install rake

# dotfiles
curl --silent https://raw.githubusercontent.com/paulmillr/dotfiles/master/install.sh | sh
curl https://raw.githubusercontent.com/skwp/dotfiles/master/vimrc > .vimrc
mkdir www
echo 'cd /var/sites/vagrant/www' >> .bashrc
echo 'zsh' >> .bashrc
ln -s /var/sites/vagrant/www www
ln -s /var/sites/vagrant/ vagrant