

Git:  
------------------------------------------------------------------------------
Git is an opensource, distributed version control system.

Local Repository:
------------------------------------------------------------------------------
The repositroy that resides in your local machine, means every developer/user can have his own local repository. this is accessable for only the local user who owns it.  containe 3 sections working area, staging area, committed files. 

Remote Repository: 
------------------------------------------------------------------------------
Its the central repository that is accessable for all the developers/users, developers can clone the remote repository to their local machine as a local copy. and start working on the project.

Git installtion:
------------------------------------------------------------------------------
go to git install document and follow the instructions
    $ sudo apt-get update
    $ sudo apt-get install git-all
    $ sudo apt-get install git-man
    
    $ git --version
    
Wokring with local repository:
------------------------------------------------------------------------------
for creating a local repository run  ` git init `, this will create a local repository in your local machine. this also create a .git folder inside the repo which will track your git repo activity. 
    $ git init
    $ touch hello.sh
    $ git status  --> shows untracked files + modified files. 
    $ git add hello.sh  --> add to stagging area
    $ git commit -m "hello world script" --> commit your changes. 

Remove from Unstaged area:
---------------------------
     $ git restore hello.v1.sh  --> revert the changes from original file before stagging area.

Remove from stagging area:
---------------------------
    $ git restore --staged hello.v2.sh  --> remove updated file from stagging area. 
    $ git rm --cached hello.sh --> remove untracked files from stagging area
        
during the 1st setup git need to know who you are, who is commiting the changes. 
    $ git config user.name "karna"
    $ git config user.email "karna@gmail.com"
  
.gitignore file:
----------------------------
this file will not track the unwanted file, so that you avoid commiting the file to git repository. you just add the neme of such files in this file. so they will not apear in the staging area. 
    $ vi my-ideas.txt
    $ vi .gitignore
    ----------------------
    .gitignore
    my-ideas.txt
    
logs:
-----------------------------
to see the git commit history 
    $ git log
    $ git log --oneline 
    
    
    
    
    
