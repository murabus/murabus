---
title: ehh - A Useful Command Line Tool
authors: 
  - admin
date: '2022-12-23'
slug: ehh-command-line-tool
categories:
  - Linux
tags:
  - Linux
  - Command Line
  - OSX
subtitle: "This is an illustration of a useful command line tool to store commands."
summary: "This is an illustration of a useful command line tool to store commands."
lastmod: '2022-12-23'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

This short post is an illustration of a powerful command line tool: [**ehh**](https://github.com/lennardv2/ehh). Using this tool, we can save commands under categories together with aliases and descriptions in command line environment. Although this tool is especially suited for longer commands, keeping track of commands used daily together in an ordered way will pay off.

After installation, we can access the list of commands already stored by typing

```
ehh
```

![my-first-image](1.png)
We can see that there are categories. I want to add the command to update .deb packages. The command we use for the purpose is:

```
sudo dpkg --i install "package name"
```
In order to save this command to use later, we add it to **ehh**:

```
ehh add
```
We add in the command (adding a (:package) will mean the command will require this input when recalled), we add description (here, update .deb package), alias is how we will call our command and group is where we assign the command.

![my-second-image](2.png)

We can see that our command is now saved under the ``software'' category:  

![my-third-image](3.png)
To illustrate the usage, we will update JabRef from version 5.7 to 5.8. After downloading the .deb package, we go to downloads folder and call our command by ehh followed by the alias:

```
ehh deb
```
The prompt package: asks us to input the name of the package. When we do that, JabRef v5.8 is installed over v5.7.

![my-third-image](4.png)
Thanks for reading![^1]

[^1]: Screenshots are from a Linux machine (Ubuntu 22.04.1 / GNOME 42.5)


