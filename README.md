# Discription
This is a bash script that makes switching between directories really easy.

# Installing Mac/Linux
1. Add the script to your PATH (on linux and Mac it is in ```/usr/local/bin/```. From here you can execute the file anywhere.
2. Add an allias in your DotRC file like so: ```alias pjs=". pjs"```. This let's you execute the script in source mode.

NOTE: when you use the script for the first time, it will make a ".project_switcher" file in your $HOME where your saved directories will be stored.

# Installing Windows
You first need to enable PowerShell execution so that you can run PowerShell scripts. Open your terminal as Administrator. Then run ```Set-ExecutionPolicy RemoteSigned```. With this you can execute PowerShell commands locally. 
Then, add the pjs.ps1 to the PATH on windows and it should work.

# Usage
The normal usage:
```
$ pjs [<number>|del <number>|save|list]"
```

You can save your current directory like this:
```
$ pjs save <ENTER>
$ Saved directory.
```

You can list your saved directories like so:
```
$ pjs list <ENTER>
$ /user/projects/webserver
  /user/projects/list_of_my_archnemeses
  /user/projects/(ethical)hackerstuff
```

And you can switch to directories by entering the number it occurs in the list:
```
$ pjs 2 <ENTER>
$ pwd
$ /user/projects/grannies_hip_mri
