
Git Install:
--------------------------------------------------------
$ sudo apt-get update
$ sudo apt-get install git-all -y
$ sudo apt-get install git-man --> git documentations 

--------------------------------------------------------
Git: (hotfix, release, enhancement, fixes, feature, 
--------------------------------------------------------

git --version	--> to check GIT version

-----------------------------------------------------------------------
config:
-----------------------------------------------------------------------
git config --global user.name "karunakar"	--> to set global user
git config --global user.email "karna@gmail.com" --> to se global email	

git config --list --system 	--> to view the git config 
git config --list --global
git config --list --local
git config --list --show-origin

-----------------------------------------------------------------------
remote:
-----------------------------------------------------------------------
git remote -v 	                                  --> to check github remote repo info
git remote add origin GitHub_Rep_URL.git -----------> adding Remote-Repo to Local-Repo.
git remote -d origin  ------------------------------> to delete the origin 
git remote rename origin my_origin -----------------> to rename the "origin" name to "my_origin"

git remote show origin --> to show the origin details

-----------------------------------------------------------------------
init:
-----------------------------------------------------------------------
git init  --------------------------> to initialize a folder as a git repo
git add README.md ------------------> to add files to  staging area. 
git commit -m "first commit" -------> to commit the stagged file

git branch -M main -----------------> update the default branch name to "main"
git remote add origin https://github.com/karunakarrao/testing.git --> adding remote repo in local system
git push -u origin main ------------> to push file to remote git-hub in to main branch

git log ---------------> to check the commit log
git log --oneline -----> to display in oneline. 
git log -p -2 ---------> to view last commited 2 details
git log --stat --------> see the log commit msg for each commit

git restore --staged file1 --> to unstage the stagged files

pull == fetech + merge

git push origin master ----> to push the data to the remote repo master branch

git branch -a -------------> to see the branch details, it will pring all branch info. remote +  local 
git branch new-branch -----> to create a new branch with name "new-branch"
git checkout -b new-branch2 --> to create a new branch and checkout new branch
git switch branch1 -----------> to switch branch branch1
git switch - -----------------> change to old branch name


TAG: to tag a specific commit 
------------------------------
git tag
git tag -a v1.0.0 -m "my app version-1.0.0 " --> to create a tag with v1.0.0

git show
git show v1.0.0 

git push origin v1.0.0 --> to push tag to github
git push origin --tags --> to list the tag details

git tag -d v1.0.0 --> to delete the tag 

Branching:
--------------------
git branch branch1 --> to create a branch1
git checkout branch1 --> to change to branch1
git switch branch1 --> to change to branch 1

git log --oneline --> to show the log output in oneline. 
git branch -d hotfix --> to delete the hotfix branch 

git branch --merged --> to check what branches are merged
git branch --no-merged 	--> not mergged branch information 

git branch --move branch1 branch3 --> Rename the branch locally
git push --set-upstream origin corrected-branch-name --> To let others see the corrected branch on the remote, push it:

restore:
--------------------------
rm test1
git restore  test1 

reset:
--------------------------
git reset --soft HEAD^ ----------> to revert the last commit done
git reset --soft HEAD~2 ---------> revert the commits back to 2 commits

git reset --hard HEAD^ ----------> it will delete completely the latest commit done
git reset --hard HEAD~3 ---------> it will delete last 3 commits done.

stash:
-------------------------
to stash the git changes, we need to first mv to stage env.

git stash
git stash show --> shows the information of a stash file
git stash list --> list of stash files

git stash pop stash@{0} --> to rework on the stashed environment.
git status --> we can see working file information
git commit -m "stashed files commiting" --> to commit the stashed file







