Assigner lets assign code reviewer to your pull request.

## Setup

```
git clone
cd assigner
bundle install
```

or

```
gem install octokit
```

## Usage

Define a list of reviewers in the `.reviewers.txt` file with the list
of GitHub usernames, one for each line.


```
GITHUB_ACCESS_TOKEN=YOUR_ACCESS_TOKEN ruby assigner.rb REPO_SLUG PULL_REQUEST_NUMBER
```

You can also provide the list of reviewers in line like:

```
GITHUB_ACCESS_TOKEN=YOUR_ACCESS_TOKEN ruby assigner.rb REPO_SLUG PULL_REQUEST_NUMBER reviewer1,reviewer2,reviewer3
```

## Travis CI

```yml
before_install:
- gem install octokit
after_success:
- if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then ruby assigner.rb $TRAVIS_REPO_SLUG $TRAVIS_PULL_REQUEST; fi
```
