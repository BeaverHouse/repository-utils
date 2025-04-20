# About Scripts

This section describes the scripts included in this repository.
Basically, all the scripts are written in 2 formats:

- Shell scripts: `*.sh`
- PowerShell scripts: `*.ps1`

## Script list

- `clean-git-branch`: Clean up the git branch
  - Used `git branch -r` to get the remote branches.  
    There was some unintended deletion when I use `git branch --merged`.
- `count-lines`: Count the lines of the file
  - Multiple files are supported, like `*.go` or `*.py`.
  - It will be stored in the separate folder.
- (Python) `init-venv`: Initialize the virtual environment
- (Python) `pytest`: Run the tests
