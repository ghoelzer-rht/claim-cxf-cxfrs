#!/bin/sh
# $1 - Expected to be desired OpenShift Namespace
# $2 - Base Domain Name
# $3 - Expected to be desired OpenShift Application Name
# $4 - Expected to be desired OpenShift Gear Size

DEMO="OpenShift xPaaS Fuse Camel CXF and CXFRS Connector"
VERSION=6.1.0
AUTHORS="Christina Lin, Greg Hoelzer"
PROJECT="git@github.com/ghoelzer-rht/claim-cxf-cxfrs.git"

OPEN_NAMESPACE=$1
OPEN_DOMAIN=$2
OPEN_NAME=$3
OPEN_GEAR=$4
OPEN_FUSE_CARTRIDGE=https://raw.githubusercontent.com/jboss-fuse/fuse-openshift-cartridge/jboss-fuse-6.1.x-379/metadata/manifest.yml

FUSE=jboss-fuse-6.1.0.redhat-379
FUSE_BIN=jboss-fuse-full-6.1.0.redhat-379.zip
DEMO_HOME=./target
FUSE_HOME=$DEMO_HOME/$FUSE
FUSE_PROJECT=./project/claimdemo
FUSE_SERVER_CONF=$FUSE_HOME/etc
FUSE_SERVER_BIN=$FUSE_HOME/bin
SRC_DIR=./installs
PRJ_DIR=./projects/claimdemo


# wipe screen.
clear 

echo
echo "#################################################################"
echo "##"
echo "##  Setting up the ${DEMO}    "
echo "##                                                             "
echo "##                                                             "
echo "##                #####  #   #  #####  #####                   "
echo "##                #      #   #  #      #                       "
echo "##                #####  #   #  #####  ####                    "
echo "##                #      #   #      #  #                       "
echo "##                #      #####  #####  #####                   "
echo "##                                                             "
echo "##                                                             "
echo "##  brought to you by:                                         "
echo "##                    ${AUTHORS}                               "
echo "##                                                             "
echo "##  ${PROJECT}                 "
echo "##                                                             "
echo "#################################################################"
echo

# double check for maven.
command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

# make some checks first before proceeding.
if [ $# -eq 4 ]
then
    echo Creating OpenShift Application $OPEN_NAME-$OPEN_NAMESPACE.$OPEN_DOMAIN using Gear Size: $OPEN_GEAR
    echo
else
    echo "execute script as follows: init <namespace> <domain> <app_name> <gear_size>"
    echo
    exit
fi

rhc create-app $OPEN_NAME $OPEN_FUSE_CARTRIDGE --namespace $OPEN_NAMESPACE --gear-size $OPEN_GEAR --timeout 600 --no-git

if [ $? -ne 0 ]; then
    echo
    echo "OpenShift Application Failed, check parameters or OpenShift Account Settings"
    exit
fi

echo
echo "################################################################"
echo "#"
echo "# Make note of the Console User/Password for future use"
echo "# during application deployment step and for Console access"
echo "#"
echo "################################################################"
echo
read -p "Press Any Key to Continue..."

cd project/claimdemo/

echo
echo Deploying demo profile to $OPEN_NAME-$OPEN_NAMESPACE.$OPEN_DOMAIN
echo enter 'y' when asked to update the Maven settings.xml and
echo the User and Password noted above when prompted
echo

mvn fabric8:deploy -Dfabric8.openshiftURL=http://$OPEN_NAME-$OPEN_NAMESPACE.$OPEN_DOMAIN

echo
echo "################################################################"
echo "#"
echo "# Logon to the created Fuse Fabric Console and complete the"
echo "# next steps in the README.md to add the JBoss/Fuse and Demo"
echo "# profiles to the created Container"
echo "#"
echo "################################################################"
echo
