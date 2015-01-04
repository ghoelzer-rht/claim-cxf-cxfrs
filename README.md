CXF & CXFRS Claim DEMO
======================================================
This demo creates web services that accept customer insurance claims, and also provides a claim cancel service.  It has been forked from the original demo created by Red Hat Technical Evangelist Christina Lyn and adapted for deployment onto our iPaaS offering, OpenShift using the Fuse 6.1 cartridge.

Fuse/Apache Camel CXF and CXFRS components are used to build the web services. The demo inlcudes 2 SOAP web services and 2 Restful Web Services. The restCancel operation reuses the cancel SOAP web service by implementing the CXF producer component.

OpenShift Application Setup
---------------------------
Make sure you have completed the basic OpenShift developer workstation setup such as installing the RHC client tools, generating and registering the supporting SSH keys.  See https://developers.openshift.com/en/getting-started-overview.html for detailed instructions.  The demo relies on using JBoss Developer Studio Version ?8? for the defined Camel Components, along with Maven for build/deployment, and JDK 1.7. Once complete, perform the following steps to create the ClaimDemo OpenShift application and Fuse Fabric with initial Container.

Step 1 - Clone this git repo into an appropriate location on your developer workstation.

Step 2 - cd to ../claim-cxf-cxfrs and run init.sh <openshift domain> <application name> <gear size> (Recommended that a Medium or Large be used, based on OpenShift Online gear sizes)

Step 3 - 
  


Fuse 6.1 Cartridge Implementation Constraints
---------------------------------------------

Setup and configuration
-----------------------

Download JBoss Fuse from jboss.org, and place the downloaded zip file under installs folder.

Add fabric server passwords for Maven Plugin to your ~/.m2/settings.xml file the fabric server's user and password so that the maven plugin can login to the fabric.

```
<server>
  <id>fabric8.upload.repo</id>
  <username>admin</username>
  <password>admin</password>
</server>
```

run 
```
init.sh
```

It will setup JBoss Fuse, install fabric, build and deploy the profile. 

To run the demo, in browser enter http://localhost:8181 and login with ID/PWD of admin/admin

Under Runtime, you will see list of containers, and click on the small icon on the righthand-side of the testcon container
![Fabric list](https://raw.githubusercontent.com/weimeilin79/claim-cxf-cxfrs/master/doc/pic/01-fabric-container-list.png?raw=true)
You can also checkout the registry
![Fabric list](https://raw.githubusercontent.com/weimeilin79/claim-cxf-cxfrs/master/doc/pic/02-registry.png?raw=true)

And either use browser to run it 
![Fabric list](https://raw.githubusercontent.com/weimeilin79/claim-cxf-cxfrs/master/doc/pic/03-browser.png?raw=true)
Or you can use SOAP UI to play with the SOAP Web Services.
![Fabric list](https://raw.githubusercontent.com/weimeilin79/claim-cxf-cxfrs/master/doc/pic/04-soapui.png?raw=true)


The demo video are located here too:

https://vimeo.com/115418661
https://vimeo.com/115560431
