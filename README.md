# Murano Lock Example

This is a self-contained example of a smart lock device, intended to provide developers an example of using Exosite's Murano platform for some common use cases. It contains code simulating both the smart lock firmware, the cloud event handlers, and the application UI. [See it in action.](https://github.com/exosite/lock-example/blob/master/images/smart-lock.gif)

It is designed to illustrate the use of Murano to build connected products and applications, including:

1. **Device data logging** periodically log the battery level of the smart lock, and update a web app in real time using the Websocket services.
2. **Device control** remotely unlock the smart lock.
3. **User access control** show how to provide user login and role-based permissions using Murano's User and Keystore services. Additionally show how to aggregate locks into dwellings (e.g. home and garage) that contain multiple locks.

In contrast to Exosite's home automation example (aka "lightbulb example") this removes any JavaScript UI framework, so that the Device API and Solution API interactions are highlighted. This makes it ideal for training developers integrating their applications with Murano. This one's for the nerds!

## Setup

### Overview
For this tutorial we'll use the Mr Murano command line utility. At a high level, here's what we'll do

* Setup Mr Murano
* Download the project source
* Create a solution and product in Murano
* Upload the solution and product details
* Run the demo!

### Setup our local project directory
* Get the project source 
  * Clone the [github repo](https://github.com/exosite/lock-example) to a location of your choosing.
* Open a command prompt and change to the project directory created above

*Note: all commands in this demo are run from this directory*

### Setup Mr Murano
* Download and install [Mr Murano](https://github.com/tadpol/MrMurano) command line utility.
* Get your business id `mr account --business`. *Note: if this is your first time running Mr Murano it will ask you for your Murano credentials. These are saved in $HOME/.mrmurano*
* Save your business id: `mr config business.id <your_business_id>`

### Create our product and solution
#### First create a product
* `mr product create lock-demo`
* Using the output of the prior command, register the product in your .mrmuranorc: `mr config product.id <id>`
* Configure your product: `mr syncup -V --specs`
* Your product is now configured. Take a few minutes to log in to Murano and view the setup of your product there.

#### Now create the solution
* `mr solution create lock-example`
* Using the output from the last command, register the solution to Mr Murano: `mr config solution.id <id>`
* Now we'll upload our solution source files to Murano.
	* `endpoints` - Files in the `endpoints` directory become routes in our Murano solution. A route is how an external app or web application can communicate with our solution
	* `eventhandlers` - When device data comes from connected devices into our solution that is processed in the even trigger. This code is in the `eventhandlers` directory.
	* `modules` - Code that is shared across routes is put in modules. Modules are libraries of functions that can be called anywhere in your solution code.
	* `files` - Your solution in Murano has a publicly accessible web address allowing you to host a web site web application using frameworks like Ember, Angular or React, to name a few. This content is stored in the `files` directory
	* *Note - all of these directory names are customizable. You can change them to suite your needs*
* `mr syncup` - this command syncs all local file system changes to Murano. *Please note: this is an overwrite. Any changes made directly in Murano will be over-written by this command*.
* Map the product created earlier to our solution: `mr assign set`

### Initialize
One final step - invoke the `_init` endpoint to load defaut settings. In your browser invoke `http://<your-solution-name>.apps.exosite.io/_init`. You should see `Ok` as a response.

At this point your solution is loaded and initialized. You can remove the _init endpoint if desired.


## Run the solution
Create two devices with identities `001` and `002`. It's important that these identities match. You can create them in the UI or at the command line like this:

```
$ mr product device enable 001
$ mr product device enable 002
```

Run simulators using the product id for the product you created earlier:
```
$ cd product
$ python simulator.py <product-id> 001
$ python simulator.py <product-id> 002
$ cd ..
```

Your solution will be available at your-solution-name.apps.exosite.io.


## TODO

- locked/unlocked graphic
- show detailed requests/responses in simulator for debugging
- test local debugging
- make simulator load in eeprom (product/device identities that are hard coded)
- make simulator save current state (e.g. battery)
- pull in a simple UI framework (e.g. bootstrap)
- port simulator to Electron to get native Windows/OSX/Linux installers
- authenticate websocket
