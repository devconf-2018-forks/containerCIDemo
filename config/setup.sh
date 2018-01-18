#!/usr/bin/env bash

oc create -f component1/component1-buildconfig-template.yaml
oc new-app component1-builder
oc create -f component2/component2-buildconfig-template.yaml
oc new-app component2-builder
oc create -f jenkins-slave/jenkins-slave-buildconfig-template.yaml
oc new-app jenkins-slave-builder

