This is template for Jekyll static site. 
It is a follow-up of [Minimal Mistakes Template](https://github.com/j3soon/minimal-mistakes-template/) supplemented with the interface of DevContainers for easy Visual Studio Code (further referred as VSCode) site authoring.
The template uses [Minimal Mistakes Theme](https://mmistakes.github.io/minimal-mistakes/).
You need Visual Studio Code and Docker to develop your site locally with this template. 

## Generating site locally

You need Docker and Visual Studio Code. Network access is required only at development environment setup and obviously, to publish the website.

### Environment setup

Download this repository as ZIP and unpack in some **empty** folder.
Remove hidden folders `.git` and `.github`, then start
Visual Studio Code
```
code .
```
Open folder in DevContainer (the appropriate dialog should appear, otherwise press green icon in left down corner).
Building the container for the first time may take substantial time. Please be patient.
When DevContainer is running, please open the terminal (in VSCode)
and start build and watch process with running script
```
srcipts/watch
```
that internally calls Jekyll site generator in continuous build mode
```
bundle exec jekyll serve --drafts --force_polling --livereload
```
The output is accessible in your default system browser at [http://localhost:4000](http://localhost:4000) or in browser built-in into VSCode.


### Development

Just run
```
code <your_site_folder>
```
Put `.` when site folder is a present working directory.
Network access is not required as all tools are already on your computer.

You can now adapt `_config.yml` to your needs and run
```
srcipts/watch
```
Please note, changes to `_config.yml` are **not** reflected in the preview - `watch` script must be restarted for that.
Section "[Authoring](#Authoring)" describes how to modify template in more detail.

At that point you can just jump directly to the template usage guide.
However, there are method that permit developing your website with less software installed on local system. This is at the price of constant network access requirement.
If you are interested, please continue reading.

## GitHub Actions

The described below method requires only Visual Studio Code installation on your local system.
The container that builds your site is created in the cloud.
GitHub gives for free 60 minutes of worker time a month.
This method can be well interleaved with local development.

Create new **Public** repository on GitHub with `.gitignore` template for Jekyll and no more files.
Then go repository `Settings -> Pages`. Select: `Source: GitHub actions`, then workflow type as `GitHub Pages Jekyll`, press button `Configure` and then `Commit` without introducing any changes to the presented configuration file.
You can check the status of build process in `Actions` menu.
The build should finish with a success, although no page was produced.

Now go back to `code`.
In file `_config.yml` set the following variables
```
url                      : "https://<gh-user>.github.io" #  "https://mmistakes.github.io"
baseurl                  : "/<repo>" # e.g. "/minimal-mistakes"
repository               : "<gh-user>/<repo> # e.g. "mmistakes/minimal-mistakes
```
Open terminal in `VSCode` and run
```
git init
git branch -M main
git remote add origin git@github.com:<your_accout>/<just_created_repo>
git pull origin main
```
Please note, that this causes that in local preview you should be opening `https://localhost:4000/<repo>`.

The built-in `code's` Git client should show you changes between your local and remote repository.
Select its icon on the left pane, select all changes by pressing `+` on `Changes` bar (it appears when bar is hoovered), enter some commit message and select `Commit` and `Synchronize` or `Publish branch`.
The commit auto-initializes the build task. You can check it progress in `Actions` menu.
Your new and shiny page is available at `https://<gh-user>.github.io/<repo>`.

## Remote Repositories

In fact, there is no need you to create a local copy of your repository and synchronize it with the remote via `Git`.
You can install extension VSCode extension `Remote Repositories` to directly open your GitHub repositories.
Please note that when switching environments you should push changes, otherwise they remain local to the enviroment created by `Remote Repositories`.
By default, pushing changes will activate the build workflow.
Please consult the file `.github/workflows/jekyll.yml` and the corresponding documentation for other methods.
The simplest approach is to leave only `workflow_dispatch:` method that activates build by pressing button on the repositorys GitHub page.

## vscode.dev

The previous two methods give you a very limited control over the container used to build your website.
The GitHub's builder uses some default container and, as developer, you have no control over it.
Unfortunately, the process of creation of the build workflow based on **yours** container is not straightforward.
As alternative to GitHub Actions one can use `vscode.dev` working environment.
In this approach there is no need you even install Visual Studio Code locally.
You just connect with VSCode server that gives you look and feel of your local VSCode.
Then serwer may open your local folder or connect to your GitHub repository.

Connect your web browser with [https://vscode.dev/](https://vscode.dev/), choose `Open Remote Repository` and select your repository (it is a two stage process, first you are asked for server - select GitHub, then enter your repository in a format `account/repo`).
Now you feel as you have been working locally with VSCode.

You can edit and push changes to your repository.


## Authoring