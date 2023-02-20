# NewSite

This is template for Jekyll static site. 
It is a follow up of [Minimal Mistakes Template](https://github.com/j3soon/minimal-mistakes-template/) supplemented with the interface of DevContainers for easy Visual Studio Code (fourther referred as VSCode) site authoring.
The template uses [Minimal Mistakes Theme](https://mmistakes.github.io/minimal-mistakes/).
You need Visual Studio Code and Docker to develop your site locally with this template. 

## How to use it?

Download this repository as ZIP and unpack in some **empty** folder.
Remove hidden folders `.git` and `.github`, then start
Visual Studio Code
```
code .
```
Open folder in DevContainer (the apriopriate dialog should appear, otherwise press green icon in left down corner).
Building the container for the first time may take substantial time. Please be patient.
When DevContainer is running, please open the terminal (in VSCode)
and start build and watch process with
```
bundle exec jekyll serve --drafts --force_polling --livereload
```
The output is accessible in your default system browser at [http://localhost:4000](http://localhost:4000) or in browser builtin into VSCode.

## Remote authoring

Create new **Public** repository on Github with `.gitignore` template for Jekyll and no more files.
Then go repository `Settings -> Pages`. Select: `Source: GitHub actions`, then workflow type as `GitHub Pages Jekyll`, press button `Configure` and then `Commit` without introducing any changes to the presented configuration file.
The status of build process you can check in `Actions` menu.
The build should finish with sucess, although no page was produced.

Now go back to `code` and run the following comands in the container
```
git init
git branch -M main
git remote add origin git@github.com:<your_accout>/<just_created_repo>
git pull origin main
```
The buildin `code's` Git client should show you changes between your local and remote repository.
Select its icon on the left pane, select all changes by pressing `+` on `Changes` bar (it appears when bar is hoovered), enter some commit message and select `Commit` and `Synchronize` or `Publish branch`.
The commit auto-initializes the build task. You can check it progress in `Actions` menu.
Your new and shiny page is available at `https://<gh-user>.github.io/<repo>`.
