# Processing Sinatra

This is a vanilla Sinatra template with basic puppet recipes that demonstrates how to run Processing on a headless server setup. This can be used to do extremely powerful image manipulation tasks, replacing ImageMagick.

This will not run on heroku. If someone if smart enough to compile a static linked binary to the /bin folder, I would be happy as hell.

## Local development

When you have Virtualbox and Vagrant installed, run the puppet provisioner.

```
vagrant up
```

Now log into your vagrant box and start sinatra:

```
vagrant ssh
cd /vagrant
shotgun -p 3000 -o 0.0.0.0
```