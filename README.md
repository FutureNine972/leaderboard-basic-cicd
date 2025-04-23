My Intro to CI and CD for Deployment
======

### Introduction
This is one of the many repos used to display my progress on web dev.

This repo is moreso intended to guide me through deployment stuff rather than actually coding websites (because I already have those basic tools down).

NEW: Learned how to deploy through GitHub Actions

#### `github-actions-demo.yml`

``` yml
name: GitHub Actions Demo
on: [push]
jobs:
  CI:
    runs-on: ubuntu-latest
    steps:
      - name: "Checkout"
        uses: "actions/checkout@v4"

      - name: "Install Requirements"
        run: pip install -r requirements.txt

      - name: "Run Tests"
        run: pytest
  CD:
    runs-on: ubuntu-latest
    # needs:
    #   - "CI"
    env:
      DEPLOY_HOST: ubuntu@${{ vars.AWS_IP }}:/home/ubuntu/deploy
    # if: github.ref == 'refs/heads/main'
    steps:
      - name: "Checkout"
        uses: "actions/checkout@v4"

      - name: "Create AWS Key File"
        run: |
          echo "${{ secrets.AWS_KEY }}" > aws.key
          chmod 0600 aws.key
          mkdir ~/.ssh
          ssh-keyscan -H ${{ vars.AWS_IP }} > ~/.ssh/known_hosts

      - name: "Debug"
        run: |
          echo ${{ vars.AWS_IP }}
          ls -la

      - name: "Deploy Files"
        run: scp -i aws.key __init__.py requirements.txt scripts/restart.sh "$DEPLOY_HOST"

      - name: "Install Pip"
        run: |
          ssh -i aws.key ubuntu@${{ vars.AWS_IP }} 'sudo apt install python3-pip -y'
      
      - name: "Install Dependencies"
        run: |
          ssh -i aws.key ubuntu@${{ vars.AWS_IP }} 'cd /home/ubuntu/deploy && pip install -r requirements.txt --break-system-packages'

      - name: "Restart Flask"
        run: |
          ssh -i aws.key ubuntu@${{ vars.AWS_IP }} 'cd /home/ubuntu/deploy && ./restart.sh'
```

This is very easy to run but there isn't really a reason to. See my [frontend](https://github.com/FutureNine972/leaderboard-basic-vue) repo for my leaderboard project (which also requires the [backend](https://github.com/FutureNine972/leaderboard-basic-flask)) for a much better Flask experience.