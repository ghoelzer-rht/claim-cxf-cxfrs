CXF & CXFRS Claim DEMO
======================================================
This demo creates web services that accept customer insurance claims, and also provides a claim cancel service.  It has been forked from the original demo created by Red Hat Technical Evangelist Christina Lyn and adapted for deployment onto our iPaaS offering, OpenShift using the Fuse 6.1 cartridge.

Fuse/Apache Camel CXF and CXFRS components are used to build the web services. The demo inlcudes 2 SOAP web services and 2 Restful Web Services. The restCancel operation reuses the cancel SOAP web service by implementing the CXF producer component.

OpenShift Application Setup
---------------------------
Make sure you have completed the basic OpenShift developer workstation setup such as installing the RHC client tools, generating and registering the supporting SSH keys.  See https://developers.openshift.com/en/getting-started-overview.html for detailed instructions.  The demo relies on using JBoss Developer Studio Version ?8? for the defined Camel Components, along with Maven for build/deployment, and JDK 1.7. Once complete, perform the following steps to create the ClaimDemo OpenShift application and Fuse Fabric with initial Container.

Step 1 - Clone this git repo into an appropriate location on your developer workstation.

Step 2 - cd to ../claim-cxf-cxfrs and run init.sh <openshift namespace> <openshift domain> <application name> <gear size> (Recommend at least a Medium gear, based on OpenShift Online gear sizes).  Follow script instructions, capturing Fuse Fabric Console information for future use and for Maven settings.xml update step within script.  Successful execution of the init.sh script will create a new OpenShift Application, Fuse Fabric and Container, and build/deploy a Demo/claim profile from the project to the OpenShift Fuse Fabric instance.

Step 3 - Verify access to created OpenShift Fuse Application and Fabric Console.  Using captured Fuse Fabric Admin UID/PWD, verify successful logon to the Fabric Console using the URL captured from Step 2.

Step 4 - Add the JBoss/Fuse/Full Profile to the created Container.  From the Fabric Console, make sure the Fabric view is selected, and then select/expand the Container (should have application name).  Select Add Profile, and scroll through list until JBoss folder is found, then expand selecting JBoss / Fuse / Full (see Screenshot below)

![Fabric list](https://raw.githubusercontent.com/ghoelzer-rht/claim-cxf-cxfrs/blob/master/doc/pic/01-fabric-container-list.png?raw=true)

Step 5 - Add the Demo/claim Profile to the created Container.  Similar to Step 4, select Add Profile, and scroll through list until Demo folder is found, then expand selecting Demo / claim (see Screenshot below)

(https://raw.githubusercontent.com/weimeilin79/claim-cxf-cxfrs/master/doc/pic/06-fabric-add-demo-claim.png?raw=true)

Step 6 - Verify that the Claim Demo profile started successfully within the Container. Switch from Fabric to Container view, and should see the following at end the log:

Route: cxfRoute started and consuming from: Endpoint[cxf://bean:claimEndpoint]
Route: applyRoute started and consuming from: Endpoint[direct://apply]
Route: cancelRoute started and consuming from: Endpoint[direct://cancel]
Route: route1 started and consuming from: Endpoint[cxfrs://bean:statusEndpoint]
Total 4 routes, of which 4 is started.
Apache Camel 2.12.0.redhat-610379 (CamelContext: blueprintContext) started in 2.810 seconds
Done.

Step 7 - Review the Fuse/Apache Camel Demo routes.  Select the Container / Camel  View and you should see that the four routes are active (see Screenshot below).

(https://raw.githubusercontent.com/weimeilin79/claim-cxf-cxfrs/master/doc/pic/07-fabric-fuse-camel-routes.png?raw=true)

Step 8 - Review the available service definitions at http://<application url>/cxf (replace <application url> with your OpenShift App)

Step 9 - Execute/Smoke Test the Demo SOAP and REST Services.  Download (if you don't already have it installed) the latest release of SOAP UI 5.x, and import the SOAP UI project provided at ../claim-cxf-cxfrs/project/soapui .  Replace <application url> with your OpenShift App within the defined SOAP and REST endpoints in the SOAP UI project.

Step 10 - (Optional) Import the Fuse Project into JBoss Developer Studio/Eclipse.  Ensure the Fuse/JBDS Plugins are installed, and import the project located at ../claim-cxf-cxfrs/project/claimdemo.  
  

Fuse 6.1 Cartridge Implementation Constraints
---------------------------------------------
For those already familiar with OpenShift having used the JBoss EAP/AS or other Web Technology Cartridges, you will have noticed some differences/constraints on the initial release of the Fuse Cartridge.  While an OpenShift application git repo can be created/associated to the OpenShift application, the typical git commit/push deployment cycle is not currently supported.  This is due to some of the complexity involved in integrating the Mavin:Fabric8 deployment plugin, which will potentially resolved in a future release.  For now, deployment must be performed as part of either a local or external CI/CD maven build with appropriate Server entry in the supporting Maven settings.xml file, which was the process used in the provided init.sh .

?Autoscaling?

?Fuse A-MQ?

Demo Videos
-----------------------

Christina Lyn has created several supporting video's installing the demo locally:

https://vimeo.com/115418661  (?Content?)
https://vimeo.com/115560431  (?Content?)
