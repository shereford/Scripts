#!/bin/bash

dnf update -y

dnf install fedora-workstation-repositories -y

dnf config-manager --set-enabled google-chrome

dnf install google-chrome-stable -y
