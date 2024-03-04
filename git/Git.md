

Git:  
------------------------------------------------------------------------------
Git is an opensource, distributed version control system. which help you maintain your code and its versions. 

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

    $ git init        ----> initialize the current directory wit Git.
    $ touch hello.sh    ---------------> Create a file 
    $ git status  ---------------------> shows untracked files + modified files. 
    $ git add hello.sh  ---------------> add to stagging area
    $ git commit -m "hello world script" -----> commit your changes locally
    
    $ git diff --color-words hello.sh -----------> diff b/w untracked modified-file vs actual-file
    $ git diff --cached --color-words hello.sh --> diff b/w stagged modified-file vs actual-file
        
    $ git reset --soft HEAD~1 --------> keep the changes in file but delete the commit entry
    $ git reset --hard HEAD~1 --------> to delete the commited chagnes 
    
config:
---------------------------------
during the 1st setup git need to know who you are, who is commiting the changes.

    $ git config user.name "karna"
    $ git config user.email "karna@gmail.com"
    
    $ git config --global user.name "karna"
    $ git config --global user.email "karna@gmail.com"
    
    $ git config --list
    $ git config --global/--local --list
       
Note: `git config --global` will set values for all your repositories. it saves configurations in `~/.gitconfig` directory
`git config` with out `--global` option this will limit for that git repository it self. it saves configurations in `~/.git` directory

restore:
---------------------------
    $ git restore hello.v1.sh           --> revert the changes from original file before stagging area.
    $ git restore --staged hello.v2.sh  --> remove updated file from stagging area. 
    
    $ git rm --cached hello.sh --> remove untracked files from stagging area
  
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
    $ git log --oneline --name-only
    
branch:
-------------------------------------
branches are used to 

    $ git branch            --> list branches 
    $ git branch -a         --> lists local and remote branches
    $ git branch feature    --> creates feature branch
    
    $ git checkout feature  --> checkout feature
    $ git checkout -b hotfix    --> creates branch hotfix + checkout hotfix
    
    $ git branch -d feature     --> delete branch feature
    $ git log --graph --decorate    --> to see branch commit history
    $ git branch -M main        --> current branch is renamed to "main"
  
    
merge:
--------------------------------------
merges are of 2 types

    1. fastforward merge: this type of merge happen when the `Master` branch has no commits, and merging `feature` branch into master then the git will select "Fastforward merge". 
    
    2. no-fastforward merge: this type of merge happen when the `master` branch has commits, and mergeing `feature` branch also has commits, this time Git will select "No fastForward merge".
    
    $ git checkout master   ------> goto master branch 
    $ git merge feature/signup  --> merge branch feature/signup in master branch.
    
    $ git log --name-only
    $ git log --graph --decoreate
    
push repo:
--------------------------------------
    $ git remote --> to list remote repo available
    $ git remote -v --> full remote repo details
    $ git remote add origin Remote_repo_URL.git  --> to add remote repo to local repo and naming the repo as "origin"
    $ git push origin master    --> to push the changes to the remote master repository
    
Note: in realtime scenario we will not push our code to master branch, insted we push to our branch then raise a PR request to merge the changes in to master branch. 

    $ git push origin my_branch --> pushing the changes to my_branch and raising the PR for to Merge into master branch. 
    
Clone repo:
----------------------------------------

    $ git clone remote_repo_URL.git
    
    $ git config --global user.name=max
    $ git config --global user.email=max@example.com
    $ git config --list-all
    
Pull & fetch repo:
----------------------------------------
we can fetch the latest changes made to remote repo to local repo using `fetch` / `pull`. if we fetch the data it will be on origin/master, to merge the changes with master branch need to run merge.

    $ git fetch origin master --> this will update origin/master branch in local repo
    $ git merge origin/master --> to merge changes to local master branch
    
 (or)   
 
    $ git pull origin sarah --> both fetch + merge are run with pull command.
    
    $ git clone git_url.git --single-branch --> clone only the remote primary HEAD (default: origin/master)
    $ git clone git_url.git --branch branch_name --single-branch --> clone a specific branch
    
merge conflict:
----------------------------------------
both developers are upto date with remote repo, they started working on same file, if 2 developers are working on the same file script.sh, both try to commit the changes done on script.sh file in remote master. then we  see merge conflict. this can be addressed by modifing the file manually. 
    
    $ git push origin master --> you failed to push your changes to remote repo, then you pull new changes
    $ git pull origin master --> then you merge both changees locally and commit the changes and push the changes.
    
fork:
-----------------------------------------
in opensource git projects, thousands of contributers are there, so every one can't be the contributer to the project. so you can fork the project and do the changes, and you can create pull request. if the owner of project think your changes are worth while they can approve the changes. and merge in to the project.

fork the git repo then clone the repo to do the changes, push the changes to your forked repo then raise a pull request to thee main repo. thanks how the read permission users can contribute to the repo.

rebase:
------------------------------------------
rebase will combine number of commits your wish to combine can be bind to gether. 

    $ git checkout master    --> first checkout master branch
    $ git pull origin master --> pull remote changes to local master branch
    $ git checkout feature   --> change to your working branch
    $ git rebase master      --> get upto-date with master branch in your local working branch(feature) 
    
    $ git rebase -i HEAD~3   --> it will merge latest 3 commits in to 1 single commit.
    $ git reset --hard ORIG_HEAD   --> this will revert the above step and reset back to previous state.
        
cherry-pick:
-------------------------------------------
if you don't want to apply all the commits just want to pick a specific commit. then use the cherry-pick

    $ git log master --oneline
    $ git cherry-pick commit-id
    
revert commit:
-------------------------------------------
to revert the commited changes. 

    $ git revert commit-id
    $ git revert HEAD~0 
    
    $ git reset --soft HEAD~1   --> it will not delete the data
    $ get reset --hard HEAD~1   --> it will delete the data
 
stash
------------------------------------------
if you don't want to commit the changes you made, but switch to other branch and do changes use the stash command, we can have may stashes. access and apply stashed changes as below 

    $ git stash     			--> it will store as cache in that branch
    $ git stash pop 			--> to revert the stash.
    $ git stash list    		--> list all the stashed files
    $ git stash show stash-id   --> to see the change in that stash-id
    $ git statsh pop stash-id   --> to unstash the changes uisng stash-id

reflog:
-----------------------------------------   
even afterr hard reset also we can revert the deleted changes. use the reflog 

    $ git reflog
    $ git reset --hard reflog-id
    
