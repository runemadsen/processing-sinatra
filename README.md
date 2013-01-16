**NOTE: I'm still working on this. The Sinatra app is currently not implemented, although the Processing calls work as described below**

# Processing Sinatra

This is a basic template with basic puppet recipes that demonstrates how to run Processing on a headless server setup. This can be used to do extremely powerful image manipulation tasks, replacing ImageMagick.

## Local development

First install Virtualbox and Vagrant. Then run the puppet provisioner:

```
vagrant up
```

Now log into your vagrant box and move to the symlinked directory:

```
vagrant ssh
cd /vagrant
```

You might need to run this:

```
rvm install ruby-1.9.3-p362
```

And now run the headless XVFB driver:

```
Xvfb :1 -screen 0 1600x1200x24 &
```

... and then run a basic processing sketch to test that it works:

```
DISPLAY=localhost:1.0 ./processing/processing-java --sketch=../sketches/test --output=../sketches/test/build --force --run
```
