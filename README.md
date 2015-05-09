# leaflet

*Leaflet iOS High Fidelity Prototype*

#### Introduction
This repository includes code written for the Leaflet project managed by the *Parks and Rec* Team (the "team") at the Carnegie Mellon University Human-Computer Interaction Institute. The project is written primarily in the Swift Programming Language, and is targeted towards deployment on iOS8.3.
The existing code is not that of a finished product, but achieves high degree of fidelity to be used for demo and user test purposes. There are purposefully unimplemented features and unifixed bugs.

#### What it Includes
* Basic application flow
* On-boarding process with Location Permission Request
* Compass Feature
* Beacon Integration and Notification Trigger
* Graphics for Stories Menu, Wwater Story and other Icons
* At Home Feature

#### Set Up
Below we describe the necessary set up for the full experience

##### Devices
A real iOS device is necessary for the full experience due to its usage of CoreBluetooth and CoreLocation Frameworks. Notably, this project takes advantages of device Heading and GPS Position for the Compass feature and Beacon technology for proximity measurement to points of interests.
Additionally, Beacons, such as the one offered by http://estimote.com, or another iOS enabled device is necessary to be used as an iBeacon.

##### API
Data on the Points of Interests are obtained from a remote server as JSON. Here, the data should contain with each point of interest the associated beacon's major, and the latitude and longitude of the beacon position. Additionally, specific information about the Point of Interest, such as its description and image should be included in the data.

##### System
The project is designed to run on iOS 8.3, and is primarily tested on the iPhone 6 device and resolution.

#### Authors and License
Code written in this repository belongs to the *Parks and Rec* Team at the Carnegie Mellon University Human-Computer Interaction Institute.. Third party sources have been acknowledged where necessary in the project.

##### Members
* Mirai Akagawa – makagawa@andrew.cmu.edu
* Tommy Doyle – tdoyle@andrew.cmu.edu
* Christina Ho – ch1@andrew.cmu.edu
* Hillary Mellin – hmellin@andrew.cmu.edu
* Cindy Zeng – czeng@andrew.cmu.edu

####$ License
The *Parks and Rec* HCI Team at Carnegie Mellon University hereby grant permission to any party who wishes to read, use or edit code written in this repository free of charge, under the MIT License. Please view the LICENSE document for details.
