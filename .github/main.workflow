workflow "build on push" {
  resolves = ["build"]
  on = "push"
}

action "build" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  runs = "npm run build"
}

workflow "publish on release" {
  on = "release"
  resolves = ["GitHub Action for npm"]
}

action "GitHub Action for npm" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  runs = "npm publish"
  secrets = ["NPM_AUTH_TOKEN"]
}