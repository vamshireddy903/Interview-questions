# What is Git Cherry-Pick?

git cherry-pick is a command that lets you apply a specific commit from one branch onto another branch, without merging the entire branch.

Instead of merging all changes, you pick only the commits you want(you don’t bring the entire branch’s history—just the commit(s) you choose.)

# Syntax
    git cherry-pick <commit-hash>

<commit-hash> → The ID of the commit you want to apply.

You can also cherry-pick multiple commits:

     git cherry-pick <hash1> <hash2> <hash3>

# How It Works

Suppose you have two branches: main and feature.

You made a commit on feature:

Commit: 123abc Add login validation

You want this commit on main without merging the entire feature branch:

    git checkout main
    git cherry-pick 123abc

Git applies the changes from that commit onto main as a new commit

# Use Cases of Git Cherry-Pick

# Hotfix to Production

Suppose a bug fix was committed in a dev branch, but you need that exact fix in main immediately. 
Instead of merging the entire dev branch, cherry-pick just that commit.

# Selective Features

If a feature branch has 10 commits but you only want 2 of them in your release branch, cherry-pick those specific commits.  

# Undo Mistakes in Wrong Branch

Sometimes, you commit a change to the wrong branch.  
You can cherry-pick that commit into the correct branch and then remove it from the wrong one.

# Backporting Fixes

If you maintain multiple versions of a project (e.g., v1.x and v2.x), you can cherry-pick important bug fixes from the latest version back into older stable branches..

# Collaborating Between Teams

Different teams work on separate branches.  
If one team produces a useful commit that another team needs, cherry-pick allows sharing specific commits without merging entire branches.
