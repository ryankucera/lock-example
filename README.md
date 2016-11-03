# Murano Lock Example

This is a self-contained example of a smart lock device, intended to provide developers an example of using Exosite's Murano platform for some common use cases. It contains code simulating both the smart lock firmware, the cloud event handlers, and the application UI. [See it in action.](https://github.com/exosite/lock-example/blob/master/images/smart-lock.gif)

It is designed to illustrate the use of Murano to build connected products and applications, including:

1. **Device data logging** periodically log the battery level of the smart lock, and update a web app in real time using the Websocket services.
2. **Device control** remotely unlock the smart lock.
3. **User access control** show how to provide user login and role-based permissions using Murano's User and Keystore services. Additionally show how to aggregate locks into dwellings (e.g. home and garage) that contain multiple locks. 

In contrast to Exosite's home automation example (aka "lightbulb example") this removes any JavaScript UI framework, so that the Device API and Solution API interactions are highlighted. This makes it ideal for training developers integrating their applications with Murano. This one's for the nerds!


## Setup

First, create solution in Murano: On the <a href="https://www.exosite.io/business/solutions">solution page</a>, click <b>+ New Solution</b>, selecting "Start from scratch" in the dropdown. You can then enter this Solution template: 

```
https://github.com/exosite/lock-example
```

After a few moments your solution will be created. Next it needs to be linked to a lock product, though. On the [products page](https://www.exosite.io/business/products) click **+ New Product** and enter this product template to create a smart lock product:

```
https://raw.githubusercontent.com/exosite/lock-example/master/product/spec.yaml
```

Install the [Exosite command line tool](https://github.com/exosite/exosite-cli). 

```
$ pip install --upgrade exosite
```

Next, clone the repository containing the solution.

```
$ git clone git@github.com:exosite/lock-example.git
$ cd lock-example
```

Initialize the `.Solutionfile.secret` by running the `--init`. Select the **Solution ID** and **Product ID** you created earlier.

```
$ exosite --init
```

Create two devices with identities `001` and `002`. It's important that these identities match. You can create them in the UI or at the command line like this:

```
$ exosite --enable_identity 001
$ exosite --enable_identity 002
```

Run simulators:
```
$ cd product
$ python simulator.py <product-id> 001
$ python simulator.py <product-id> 002
$ cd ..
```

Deploy the solution:

```
$ exosite --deploy
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
