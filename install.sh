#!/usr/bin/env bash
#based on https://gist.github.com/niallobrien/8252013

echo "--- Let's get to work. Installing now. ---"

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- MySQL time ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl python-software-properties

echo "--- We want the bleeding edge of PHP ---"
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql git-core build-essential php5-xdebug libmcrypt-dev mcrypt

sudo a2enmod rewrite
sudo a2enmod gd

echo "--- configure git ---"

su vagrant -c 'git config --global color.ui true'
su vagrant -c 'git config --global core.editor "vim"'
su vagrant -c 'git config --global color.branch auto'
su vagrant -c 'git config --global color.status auto'
su vagrant -c 'git config --global color.diff auto'
su vagrant -c 'git config --global alias.st status'

su vagrant -c 'git config --global user.name "ruizfrontend"'
su vagrant -c 'git config --global user.email ruizfrontend@gmail.com'
su vagrant -c 'cat /vagrant/git-show-branch.txt >> $HOME/.bashrc'

su vagrant -c "echo 'export PATH=$HOME/local/bin:$PATH' >> /home/vagrant/.profile"

echo "--- Installing node.js ---"
su vagrant -c 'curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -'
su vagrant -c 'apt-get install -y nodejs'

su vagrant -c 'npm install -g grunt-cli'
su vagrant -c 'npm install -g yo'
su vagrant -c 'npm install -g bower'
su vagrant -c 'npm install -g cordova'
su vagrant -c 'npm install -g ionic'

echo "--- Installing Ruby ---"
sudo apt-get update
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
source /home/vagrant/.rvm/scripts/rvm
source "$HOME/.rvm/scripts/rvm" >> ~/.bash_profile
rvm install 2.2.1 --default
rvm requirements

gem install foundation
gem install compass
gem install jekyll


echo "--- Turn on errors ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo "--- Install Composer (PHP package manager) ---"
su vagrant -c 'curl -sS https://getcomposer.org/installer | php'

su vagrant -c 'sudo mv composer.phar /usr/local/bin/composer'

su vagrant -c 'a2dissite default'
su vagrant -c 'cp /vagrant/vagrant.conf /etc/apache2/sites-available/'
su vagrant -c 'a2ensite vagrant'

ln -s /vagrant/www ~/www
sudo rm -rf /var/www/

echo "--- Restarting Apache ---"
sudo service apache2 restart

# curl http://j.mp/spf13-vim3 -L -o - | sh

echo "--- All done, enjoy! :) ---"