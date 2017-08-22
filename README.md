{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf830
{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fswiss\fcharset0 ArialMT;}
{\colortbl;\red255\green255\blue255;\red11\green85\blue25;\red255\green255\blue255;}
{\*\expandedcolortbl;;\cssrgb\c0\c40000\c12941;\cssrgb\c100000\c100000\c100000;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}
{\list\listtemplateid2\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid101\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid2}
{\list\listtemplateid3\listhybrid{\listlevel\levelnfc0\levelnfcn0\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{decimal\}.}{\leveltext\leveltemplateid201\'02\'00.;}{\levelnumbers\'01;}\fi-360\li720\lin720 }{\listname ;}\listid3}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}{\listoverride\listid2\listoverridecount0\ls2}{\listoverride\listid3\listoverridecount0\ls3}}
\margl1440\margr1440\vieww9000\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 ## BBDN-3LO-REST-Demo\
\
The purpose of this project is to demonstrate the workflow involved in Blackboard Learn's three-legged OAuth model (3LO), introduced in release 3200.7. For more information visit the <a href="https://community.blackboard.com/community/developers/rest" target="_blank">REST Developer Community</a> space on the Blackboard Community site. For demonstration purposes, this tutorial is written in Swift 3 and uses several CocoaPods to assist in functionality. Specifically, the app redirects a user to a Learn instance at load, allowing the user to login if not already logged in, and authorize the app, if not already authorized, and then using that authorization code, pull a token and make an authenticated REST request as that user to pull the users course memberships and display them in a UITableView.\
\
Please note that this project is intended to demonstrate Blackboard Learn's APIs. It is not meant to be a Swift tutorial \
\
### Project at a Glance\
\
\pard\tx220\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\li720\fi-720\pardirnatural\partightenfactor0
\ls1\ilvl0\cf0 {\listtext	\'95	}Target: Blackboard Learn 3200.7 or later\
{\listtext	\'95	}Source Release: 1.0\
{\listtext	\'95	}Release Date: 2017-08-22\
{\listtext	\'95	}Author: Scott Hurrey\
\pard\tx560\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 \
### Developer Notes\
\
\pard\tx220\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\li720\fi-720\pardirnatural\partightenfactor0
\ls2\ilvl0\cf0 {\listtext	\'95	}MacOS 10.12.6\
{\listtext	\'95	}IDE: Xcode 8.3.3\
{\listtext	\'95	}iOS 10.3\
{\listtext	\'95	}Swift 3.1\
{\listtext	\'95	}CocoaPods 1.1.1\
{\listtext	\'95	}Alamofire 4.2.0\
{\listtext	\'95	}SwiftyJSON 3.1.3\
{\listtext	\'95	}Simulator set to iPhone 7\
{\listtext	\'95	}You will need Ruby to install CocoaPods\
\pard\tx560\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 \
### Setting up Your Project\
\
\pard\tx220\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\li720\fi-720\pardirnatural\partightenfactor0
\ls3\ilvl0\cf0 {\listtext	1.	}Make sure you have the latest Xcode installed\
{\listtext	2.	}Check to see if you have Swift installed by opening a Terminal window and entering 
\i swift --version
\i0  at the prompt and hitting ENTER. To install Swift, visit <a href="
\f1\fs28 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 https://swift.org/getting-started
\f0\fs24 \cf0 \cb1 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 " target="_blank">Getting Started</a> on Swift.org\
\ls3\ilvl0{\listtext	3.	}Check to see if you have CocoaPods installed by opening a Terminal window and entering 
\i pod --version
\i0  at the prompt and hitting ENTER. To Install CocoaPods, open a terminal window and enter 
\i sudo gem install cocoapods
\i0  at the command prompt and hit ENTER.\
{\listtext	4.	}Once the pre-requisites are installed, the first step is to clone this repository.git clone https://github.com/blackboard/BBDN-3LO-REST-Swift.git\
{\listtext	5.	}Once this is completed, you will need to install the correct pods. Change directories to Blackboard 3LO and type: pod install This will install Alamofire (HTTP library) and SwiftyJSON. Now open XCode and select the Blackboard 3LO.xcworkspace file to open. You may see errors related to xcode settings causing one or both of the pods to fail. If this occurs, click the Blackboard 3LO link illustrated here: <img src=""> and from the dropdown, select the pod that is giving you issue, and press CMD-B to build. It will highlight any errors you encounter and prompt you to fix them automatically.\
{\listtext	6.	}Next, edit the bb-config.plist file to enter your DOMAIN including the protocol (i.e. https://monument.edu), your REST key and your REST secret. \
{\listtext	7.	}Now, simply click the start icon to run the application in the simulator.\
\pard\tx560\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 \
\
\
\
\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 \
}