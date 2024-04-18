
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
    
local repository:
------------------------------------------------------------------------------
creating a local repository, run  ` git init ` this will create a local repository in your local machine. this also create a `.git` folder inside the repo which will track your repo activity. 

    $ git init        	--> initialize the current directory wit Git.
    $ git status  		--> shows untracked files + modified files. 
    $ git add hello.sh  --> add to stagging area
    $ git commit -m "hello world script" 	--> commit your changes locally
   
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

diff:
-----------------------------------
To check the  difference between modified and original file.

    $ git diff --color-words hello.sh 			--> diff b/w modified-file vs actual-file
    $ git diff --cached --color-words hello.sh 		--> diff b/w stagged modified-file vs actual-file. --cached will refer the staged area.


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
	
revert commit: (Safe way to  revert changes)
-----------------------------------------------
to revert the commit. This will not delete the commit-ID from the log history, but it will delete the actual changes in the file. it will create an aditional commit. you can delete any specific commit-ID in commit history.

    $ git revert HEAD 			--> This will  revert the Latest Commit
    $ git revert commit-id		--> This  will revert the specific commit
    $ git revert HEAD~0 		--> This will revert the lastest commit.
    $ git revert --skip			--> to skip revert operations during conflicts.
    
reset: ( DANGER ) Destructive Operation. (--soft/--hard/--mixed)
----------------------------------------------------------------
To reset the commit, we can use revert/reset. but reset will delete the commit-ID from commit history. this is useful for personal level. not recommunded with teams. you can delete your personal branch. 

    $ git reset --soft HEAD~1 	--> keep the changes in file, but delete the commit-ID
    $ git reset --hard HEAD~1 	--> Delete both Commit-ID + Changes in files.
	
restore:
---------------------------
To restore the changes from staging area to unstaged area. 

    $ git restore hello.v1.sh           --> modified changes will get reverted. original 
    $ git restore --staged hello.v2.sh  --> remove file from stagging area to  modified files area which is untracked area.
    
    $ git rm --cached hello.sh 		--> remove untracked files from stagging area
	
branch:
-------------------------------------
branches are used to create a new branch from your working  branch. You can  create a dummy branch from any  branch master/feature/hotfix/other.

    $ git branch            	--> list branches 
    $ git branch -a         	--> lists local and remote branches
    
    $ git branch feature    	--> creates a branch named  "feature"
    $ git checkout feature  	--> checkout/move/switch to newly created  "feature"
    $ git checkout -b hotfix    --> creates branch name "hotfix" and  switch/move to new branch "hotfix"

    $ git branch -d feature		--> only get deleted  if the branch merged in to main branch.
    $ git branch -D feature     	--> delete branch feature
    $ git log --graph --decorate    	--> to see branch commit history
    $ git branch -M main        	--> current branch is renamed to "main"
    
merge:
--------------------------------------
merges are of 2 types

    1. fastforward merge: this type of merge happen when the `Master` branch has no commits, and merging `feature` branch into master then the git will select "Fastforward merge". 
    2. no-fastforward merge: this type of merge happen when the `master` branch has commits, and mergeing `feature` branch also has commits, this time Git will select "No fastForward merge".
    
    $ git checkout master  			--> To merge feature/signup branch -> master, first switch/move to master branch. then run merge command.
    $ git merge feature/signup  		--> merge branch feature/signup in master branch.
    
    $ git log --name-only
    $ git log --graph --decoreate
    
push repo:
--------------------------------------
Push your  changes to remote repository  in GitHub/Bitbucket/Gitlab.  

    $ git remote 		--> to list remote repos available
    $ git remote -v 		--> full remote repo details with  clone URL.
	
    $ git remote add origin Remote_repo_URL.git  	--> to add remote repository locally. your git repo and remote-repo as "origin". you  can name as you like.
    $ git push origin master    			--> to push your local changes to the remote master branch.
    $ git push origin my_branch 			--> pushing the changes to my_branch and raising the PR for to Merge into master branch. 

 Note: in realtime scenario we will not push our code to master branch, insted we push to your branch then raise a PR request to merge the changes in to master branch. 
    
Clone repo:
----------------------------------------
To clone  remote repository locally we use clone. 

    $ git clone remote_repo_URL.git			--> copy remote repo URL and clone. if its private you need login/ share SSH keys.
    
Pull & fetch repo:
----------------------------------------
Both git `pull` and git `fetch` have their advantages and use-cases. If you want a quick way to update your local repository and you  are sure that there won’t be any merge conflicts, `git pull` is a suitable option. On the other hand, if you want a safer, more flexible way to review changes before merging, then `git fetch` is the better choice.

    $ git fetch origin master 	--> fetch your remote changes locally, then review using diff command. 
    $ git diff  origin master	--> check  the difference  between remote/local repo. then run  merge your changes  using merge.
    $ git merge origin/master 	--> to merge changes to local master branch
    $ git rebase master		--> Rebasing helps in maintaining a cleaner commit history by incorporating changes from the master branch into your feature branch in a linear manner. 

 (or)
 
    $ git pull origin sarah 	--> both fetch + merge are run with pull command.
    $ git rebase master	
	
    $ git clone git_url.git --single-branch 				--> clone only the remote master  branch (default: origin/master)
    $ git clone git_url.git --branch branch_name --single-branch 	--> clone a specific branch 

  Note: `git rebase master` after `git fetch` or `git pull` helps in maintaining a cleaner commit history, avoiding the creation of merge commits.
  
merge conflict:
----------------------------------------
both developers are upto date with remote repo, they started working on same file, if 2 developers are working on the same file `script.sh`, both try to commit the changes done on `script.sh` file in remote master. then we  see merge conflict. this can be addressed by modifing the file manually. 
    
    $ git push origin master 	--> you failed to push your changes to remote repo, then you pull new changes
    $ git pull origin master 	--> then you merge both changees locally and commit the changes and push the changes.
    
rebase: (DANGER) - Golden Rule
------------------------------------------
Rebasing with `git rebase` allows for integrating changes from one branch onto another, maintaining a clean commit history, avoiding merge commits, resolving conflicts efficiently, and syncing forked repositories. (Golden rule of rebase, never use it on public branches. You should  never rebase master onto  a feature branch.)

usecase-1: updating the new commit  histroy with feature branch, to make sure its up-to date.

    $ git checkout master    	--> first checkout master branch
    $ git pull origin master 	--> pull remote changes to local master branch
    $ git checkout feature   	--> change to your working branch
    $ git rebase master      	--> get upto-date with master branch in your local working branch(feature) 

usecase-2: to combine the multipule commits into a single commit using the 

    $ git rebase -i HEAD~3   		--> it will merge latest 3 commits in to 1 single commit. "-i" interactive  rebase.  it will  rewrite the commit-ID's with new ID.
    $ git reset --hard ORIG_HEAD   	--> this will revert the above step and reset back to previous state.

usercase-3: Druing rebase conflicts  use the below options.

 	$ git rebase -i HEAD~3			--> combine laste 3 commits.  but failed  
	$ git rebase --edit-todo		--> edit rebase again
 	$ git rebase --continue			--> continue with rebase activity.

cherry-pick:
-------------------------------------------
if you don't want to apply all the commits just want to pick a specific commit. then use the cherry-pick

    $ git log master --oneline
    $ git cherry-pick commit-id		--> picking a specific commit to  add changes.
    
stash
------------------------------------------
if you don't want to commit the changes you made, but switch to other branch and do changes use the `stash` command, we can have many stashes. access and apply stashed changes as below.

    $ git stash     		--> it will store as cache in that branch
    $ git stash pop 		--> to revert the stash.
    $ git stash list    	--> list all the stashed files
    $ git stash show stash-id   --> to see the change in that stash-id
    $ git statsh pop stash-id   --> to unstash a  specific stash-id

reflog:
-----------------------------------------   
even afterr hard reset also we can revert the deleted changes. use the reflog. its the mother of all git logs. 

    $ git reflog
    $ git reflog commit-ID
    $ git reset --hard reflog-id

to create dummy commits. using for loop

    $ for i in {1..5}; do echo $(date) > testfile_$i; git add .;  git commit -m "testing _$i"; done

hooks:
-----------------------------------------

secreats
-----------------------------------------

	$ git screats.
    
fork:
-----------------------------------------
in opensource git projects, thousands of contributers are there, so every one can't be the contributer to the project. so you can fork the project and do the changes, and you can create pull request. if the owner of project think your changes are worth while they can approve the changes. and merge in to the project.

fork the git repo then clone the repo to do the changes, push the changes to your forked repo then raise a pull request to thee main repo. thanks how the read permission users can contribute to the repo.
