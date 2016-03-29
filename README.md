# vagrantBase
## Vagrant machine para desarrollo web

Para hacerla funcionar instalamos primero virtualbox y vagrant:  
https://www.virtualbox.org/wiki/Downloads  
https://www.vagrantup.com/downloads.html  

Descomprimimos el repositorio en una carpeta, y accediendo en la linea de comando a ella escribimos
```
vagrant up
```
Vagrant descargará la máquina y procederá a instalar el sistema completo. 
Si todo funciona correctamente podremos acceder al sistema ya montado mediante
```
vagrant ssh
```

### Incluye
apache, php, ruby (compass, jekyll, foundation) y nodejs (grunt, yeoman, bower, cordova, ionic)

### Configuración
Antes de instalar el sistema deberías cambiar la configuración de git con tus datos:
```
su vagrant -c 'git config --global user.name "NOMBRE DE USUARIO"'
su vagrant -c 'git config --global user.email EMAIL'
```
