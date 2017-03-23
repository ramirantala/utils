import os
import click

from github3 import enterprise_login

github_url = os.environ['GITHUB_URL']
github_token = os.environ["GITHUB_TOKEN"]

@click.command()
@click.option('--user', default=None, help='')
@click.option('--repo', default=None, help='')
@click.option('--pr', default=None, help='')
def create(user, repo, pr):
    gh3 = enterprise_login(url=github_url, token=github_token)
    user = gh3.user(user)
    repo = gh3.repository(user, repo)
    issue = repo.issue(pr)
    issue.create_comment(":+1:")

if __name__ == '__main__':
        create()


