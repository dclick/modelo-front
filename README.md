[![Circle CI](https://circleci.com/gh/dclick/modelo-front/tree/master.svg?style=shield&circle-token=c43d070b6820841e467e6f502e25077e6bf3cb30)](https://circleci.com/gh/dclick/modelo-front/tree/master)

# modelo-front

**WARNING - This project is based in the back end of the project [sesc-motofrete](https://github.com/dclick/sesc-motofrete), so, if you want to see working, please, run the back end of this project**

#Instructions to start developing

**If you are using WINDOWS, consider use Vagrant with an Ubuntu Box inside, and don't run GULP in your guest JUST IN YOUR HOST**

1 - Install HomeBrew

```
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```


2 - Install Git
```
sudo apt-get install git

```

3 - Install NodeJS
```
cd ~/

git clone https://github.com/visionmedia/n.git

cd n

make install

FOR UBUNTU
sudo apt-get install curl

FOR MAC OS
brew install curl

sudo n stable

```

4 - Install Global Modules
```
sudo npm install -g gulp

sudo npm install -g bower

```

5 - Install Node Modules
```
npm install

```

6 - Install Bower Components
```

bower install

```

7 - Run
```
gulp serve

//you can use this command below to run the test
sudo gulp test

//or for watch
sudo gulp test:auto
```

#Configs

##Back End Proxy
```
go to folder ./gulp/proxy.js

and modify line 24 (proxyTarget)
```

##Other Configs

```
Edit the file ./sesc-config/config.js

APP_BASE_URL = global var that you can use in services urls
APP_USER_NOT_AUTH_REDIRECT = if the user is not authenticated, this is the default route that you trasnfer him
APP_OTHERWISE_URL = default route that will transfer the user when he enter in the app
APP_BASE_URL_GESTOR_ACESSO = url base of the Access Manager
```


##Guideline Components

```
All the components are in the folder src/components/guideline
```

##Static Distribution

```
Modify the path in the gulpfile.js in the root folder
```

#i18n

```
The project contains i18n, all the translations should be placed in 
/src/i18n/"language".json

to use in the HTML, put the directive translate, follow the example
 <button class="btn btn-primary" translate>listagem.ADICIONAR</button>
```

##CircleCI

```
to configure the integration with CircleCI, change the file generateVersion.sh

change **backend_folder**
```