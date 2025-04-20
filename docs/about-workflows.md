# About Workflows

This section describes the GitHub Actions workflow files included in this repository.
All workflow files are written in YAML format.

## Workflow Files List

### [CodeQL](https://codeql.github.com/)

CodeQL is a static analysis tool that can be used to analyze code for security vulnerabilities.  
The basic format can be easily setup via the GitHub UI.

There are 3 workflows for different languages.

- `codeql-default.yml`: Default
- `codeql-golang.yml`: Go Language
- `codeql-python.yml`: Python Language

CodeQL will be triggered on push to `main` branch and some specific branches.

> [!CAUTION]
> When using secrets.GITHUB_TOKEN, CodeQL is not triggered via pull request events.  
> It's restricted by design; refer to [peter-evans/create-pull-request#48](https://github.com/peter-evans/create-pull-request/issues/48)
>
> If you need to trigger CodeQL via pull request, you need to use a personal access token.  
> However, I wanted the bot to make the PR, so I set a push event trigger instead.

### File Sync

**This workflow is used only in current repository.**  
It uses the [BetaHuhn/repo-file-sync-action](https://github.com/BetaHuhn/repo-file-sync-action) to sync files between repositories.  
I set `SKIP_PR` to `true` to avoid creating PRs with PAT.

- `sync-files-organization.yml`: File sync for organization repositories
- (TBU) `sync-files-personal.yml`: File sync for personal repositories

### Pull Request Management

- `auto-pr.yml`

  - Automatically creates and merges pull requests from issue branches.
  - Triggers on creation and push to branches starting with numbers.
    - These branches are created from issues.
  - Extracts issue information and labels for PR creation.
  - Enables auto-merge with squash strategy.

- `auto-pr-file-sync.yml`

  - Similar to `auto-pr.yml` but specifically for `file-sync` branch.
  - It skips the issue information extraction, because it doesn't exist.

> [!IMPORTANT]
>
> 1. You need to set `fetch-depth: 0` to fetch all history.
> 2. To set multiline strings to GITHUB_OUTPUT, follow [this link](https://github.com/orgs/community/discussions/116619#discussioncomment-8994849)

> [!NOTE]
>
> You can use `gh pr create` or `peter-evans/create-pull-request` workflow to create PRs.  
> Both of them are recommended. (Peter Evans is the staff of GitHub, so it's quite reliable.)
>
> However, `gh pr create` is more recommended when you need to create PRs from existing branches.  
> Please refer to [Common issues - peter-evans/create-pull-request](https://github.com/peter-evans/create-pull-request/blob/main/docs/common-issues.md#create-using-an-existing-branch-as-the-pr-branch)

### Stale Issue and PR Management

It is implemented in `close-stale.yml`, using `actions/stale` workflow.

- Automatically marks and closes stale issues and pull requests.
  - It runs periodically.
  - Marks items as stale after 30 days of inactivity, then closes them immediately.
  - Deletes branches of closed PRs.

> [!TIP]
> To close issues immediately after stale, I referred to [this issue](https://github.com/actions/stale/issues/711).

### Label Synchronization

It is implemented in `sync-labels.yml`, using `micnncim/action-label-syncer`.
