# BBDN-3LO-REST-Demo

The purpose of this project is to demonstrate the workflow involved in Blackboard Learn's three-legged OAuth model (3LO), introduced in release 3200.7. For more information visit the <a href="https://community.blackboard.com/community/developers/rest" target="_blank">REST Developer Community</a> space on the Blackboard Community site. For demonstration purposes, this tutorial is written in Swift 3 and uses several CocoaPods to assist in functionality. Specifically, the app redirects a user to a Learn instance at load, allowing the user to login if not already logged in, and authorize the app, if not already authorized, and then using that authorization code, pull a token and make an authenticated REST request as that user to pull the users course memberships and display them in a UITableView.

Please note that this project is intended to demonstrate Blackboard Learn's APIs. It is not meant to be a Swift tutorial.

### Project at a Glance

* Target: Blackboard Learn 3200.7 or later
* Source Release: 2.0
* Release Date: 2019-09-30
* Author: Scott Hurrey

### Developer Notes

* MacOS 10.13.6
* IDE: Xcode 10.1
* iOS 12.1
* Swift 4.2.1
* CocoaPods 1.7.1
* Alamofire 4.2.0
* SwiftyJSON 5.0.0
* Simulator set to iPhone 7
* You will need Ruby to install CocoaPods

### Setting up Your Project

1.	Make sure you have the latest Xcode installed

2.	Check to see if you have Swift installed by opening a Terminal window and entering `swift --version` at the prompt and hitting ENTER. To install Swift, visit (https://swift.org/getting-started "Getting Started") on Swift.org

3.	Check to see if you have CocoaPods installed by opening a Terminal window and entering `pod --version` at the prompt and hitting ENTER. To Install CocoaPods, open a terminal window and enter `sudo gem install cocoapods` at the command prompt and hit ENTER. If you are not on CocoaPods 1.8.1, you will need to update, by opening a terminal window and entering `sudo gem install cocoapods` and pressing ENTER.

4.	Once the pre-requisites are installed, the first step is to clone this repository.

      `git clone https://github.com/blackboard/BBDN-3LO-REST-Swift.git`

5.	Once this is completed, you will need to install the correct pods. Change directories to Blackboard 3LO and type: 

      `pod install`

      This will install Alamofire (HTTP library) and SwiftyJSON. Now open XCode and select the Blackboard 3LO.xcworkspace file       to open. You may see errors related to xcode settings causing one or both of the pods to fail. If this occurs, click the       Blackboard 3LO link illustrated here: 

      !["Image showing the xcode interface and where to click in order to switch the current project"]            (https://s3.amazonaws.com/bbdn-images/3LO+project+selector.png "Project Selector") 

      and from the dropdown, select the pod that is giving you issue, and press CMD-B to build. It will highlight any errors         you encounter and prompt you to fix them automatically.

6.	Next, edit the bb-config.plist file to enter your DOMAIN including the protocol (i.e. https://monument.edu), your REST key and your REST secret. 

7.    You need to make a manual change to the SwiftyJSON build settings, as it cannot be compiled under Swift 5.0, even though the project is set to use 4.2. See this video for instructions.

https://drive.google.com/file/d/1wynu5RyaFCJhUyoYi8zP6DxFNKTkIQQO/view?usp=sharing

8.	Now, simply click the start icon to run the application in the simulator.

## License Information

> Copyright © 2019 Blackboard Developer Community. All rights reserved.
>
> Redistribution and use in source and binary forms, with or without
> modification, are permitted provided that the following conditions are met:
>
>  -- Redistributions of source code must retain the above copyright
>     notice, this list of conditions and the following disclaimer.
>
>  -- Redistributions in binary form must reproduce the above copyright
>     notice, this list of conditions and the following disclaimer in the
>     documentation and/or other materials provided with the distribution.
>
>  -- Neither the name of Blackboard Inc. nor the names of its contributors
>     may be used to endorse or promote products derived from this
>     software without specific prior written permission.
>
> THIS SOFTWARE IS PROVIDED BY BLACKBOARD INC ``AS IS'' AND ANY
> EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> DISCLAIMED. IN NO EVENT SHALL BLACKBOARD INC. BE LIABLE FOR ANY
> DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
