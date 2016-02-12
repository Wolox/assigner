#!/usr/bin/env ruby

# ruby assigner.rb REPOSITORY PULL_REQUEST_NUMBER [REVIEWERS_LIST]
require 'octokit'

def error(message)
  puts message
  puts ""
  puts "Usage:"
  puts "    ruby assigner.rb REPOSITORY PULL_REQUEST_NUMBER [REVIEWERS_LIST]"
  puts ""
  exit 1
end

repo = ARGV[0]
pull_request_number = ARGV[1]
github_access_token = ENV["GITHUB_ACCESS_TOKEN"]

error "You must provide the repository name" unless repo
error "You must provide the pull request number" unless pull_request_number
error "You must provide the GitHub access token using the env variable GITHUB_ACCESS_TOKEN" unless github_access_token

client = Octokit::Client.new(access_token: github_access_token)
reviewers = File.readlines(".reviewers.txt")
assigned_reviewer =
  if ARGV[2]
    ARGV[2].split(",").sample
  else
    error "You should provide a list of reviewers either using a '.reviewers.txt' file or as cmd line parameter" unless File.exist?(".reviewers.txt")
    reviewers = File.readlines(".reviewers.txt")
    reviewers.sample
  end

puts "The assigned reviewer for '#{repo}##{pull_request_number}' is @#{assigned_reviewer}"
client.update_issue(repo, pull_request_number, { assignee: assigned_reviewer })
