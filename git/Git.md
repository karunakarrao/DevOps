

Git:  
------------------------------------------------------------------------------
Git is an opensource, distributed version control system.

Local Repository:
------------------------------------------------------------------------------
The repositroy that resides in your local machine, means every developer/user can have his own local repository. this is accessable for only the local user who owns it.  containe 3 sections working area, staging area, committed files. 

Remote Repository: 
------------------------------------------------------------------------------
Its the central repository that is accessable for all the developers/users, developers can clone the remote repository to their local machine as a local copy. and start working on the project. we can host our remote repo on "GitHub" / "GitLab" / "BitBucket".

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
    $ git reset --hard HEAD~1 --> to delete the commited chagnes 

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
    $ git log --name-only
    
branch:
-------------------------------------
branches are used to 
    $ git branch            --> list branches 
    $ git branch -a         --> both local and remote branch information.
    $ git branch feature    --> creates feature branch
    $ git checkout feature  --> checkout feature
    $ git checkout -b hotfix    --> creates branch hotfix + checkout hotfix
    $ git branch -d feature     --> delete branch feature
    $ git log --graph --decorate    --> to see branch commit history
    $ git branch -M main        --> current branch is renamed to "main"
  
    
merge:
--------------------------------------
merges are of 2 types
    1. fastforward merge
    2. no-fastforward merge
    
    $ git checkout master
    $ git merge feature/signup  --> merge branch feature/signup in master branch.
    
    $ git log --name-only
    $ git log --graph --decoreate
    
push repo:
--------------------------------------
    $ git remote --> to list remote repo available
    $ git remote -v --> full remote repo details
    $ git remote add origin Remote_repo_URL.git  --> to add remote repo to local repo and naming the repo as "origin"
    $ git push origin master
    
Note: in realtime scenario we will not push our code to master branch, insted we push to our branch then raise a PR request to merge the changes in to master branch.    
    $ git push origin my_branch
    
Clone repo:
----------------------------------------
    $ git clone remote_repo_URL.git
    $ git log 
    $ git config --global user.name=max
    $ git config --global user.email=max@example.com
    $ git config --list-all
    
Pull & fetch repo:
----------------------------------------
we can fetch the latest changes made to remote repo to local repo using `fetch` / `pull`. if we fetch the data it will be on origin/master, to merge the changes with master branch need to run 

    $ git fetch origin master --> this will update origin/master branch in local repo
    $ git merge origin/master --> to merge changes to local master branch
 (or)   
    $ git pull origin sarah --> both fetch + merge are run with pull command.
    
merge conflict:
----------------------------------------
both developers are upto date with remote repo, they started working on same file, if 2 developers are working on the same file script.sh, both try to commit the changes done on script.sh file in remote master. then we  see merge conflict. this can be addressed by modifing the file manually. 
    $ 
