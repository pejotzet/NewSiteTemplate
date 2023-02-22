This is template for Jekyll static site. 
It is a follow-up of [Minimal Mistakes Template](https://github.com/j3soon/minimal-mistakes-template/) supplemented with the interface of DevContainers for easy Visual Studio Code (further referred as VSCode) site authoring.
The template uses [Minimal Mistakes Theme](https://mmistakes.github.io/minimal-mistakes/).
<!-- You need Visual Studio Code and Docker to develop your site locally with this template.  -->

This project is [hosted](https://github.com/pzktit/NewSite) on GitHub.
The demo generated by the GitHub Actions is available at [https://pzktit.github.io/NewSite](https://pzktit.github.io/NewSite).

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
Building the container for the first time may take substantial time. Please be patient and `postCreate` and `postStart` scripts will finish their jobs.
When you will the Jekyll version displayed, it means that the DevContainer is up.
Please open the terminal (in VSCode) and start continuous build and watch process by running
```
srcipts/watch
```
The `watch` script internally calls Jekyll site generator in continuous build mode
```
bundle exec jekyll serve --drafts --force_polling --livereload
```
The live output is accessible in your default system browser at [http://localhost:4000](http://localhost:4000) or in browser built-in into VSCode.


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

Moreover, there is no need you even install Visual Studio Code!
Connect your web browser with [https://vscode.dev/](https://vscode.dev/), choose `Open Remote Repository` and select your repository (it is a two stage process, first you are asked for server - select GitHub, then enter your repository in a format `account/repo`).
Now you feel as you have been working locally with VSCode.

You can edit and push changes to your repository.
So in this method the web browser is the only software you need to make development using `GitHub Actions`. 

## Codespaces

The previous non-local methods give you a very limited control over the container used to build your website.
The GitHub's builder uses some default container and, as developer, you have no control over it.
Unfortunately, the process of creation of the custom workflow based on **yours** container is not straightforward.
As alternative to `GitHub Actions` one can use `Codespaces` working environment.
In this approach there is no need you to install anything except the web browser.

Open your acoout page on GitHub (`https://github.com/your-account`), then select `Codespaces`.
Press button `New Codespace` and fill-in required information.
The virtual machine you've just hired in the cloud will start create DevContainer defined in the repository, just like your PC was in "[Generating site locally](#Generating-site-locally) approach.
Please be patient until `PostCreate` and `PostStart` sripts will finish their jobs.
Since then you can work on a remote PC as on your local machine.
You can start the `scripts/watch` to see online results of your work (please add the value of `baseurl` after the presented link if you see `404 not found` error).

The word of caution. Using `Codespaces` you are hiring virtual machine in the cloud.
This service is not free.
The **activity** of this machine counts to the mentioned earlier **60h/month** limit.
The key word here is **activity**. Please remember to deactivate machine when finished.

**You have been warned!**

Now we can go to more pleasant topic.

## Authoring of pages

You can remove or rename entries in the navigation bar by editing `_data/naviagtion.yml`.
Images used by your pages should be stored in folder `assets/images/`.
The input for Jekyll is prepared in Markdown - a very efficient markup language.
Jekyll processes that input and creates HTML output on a basis of templates defined inside theme.
Every input file is equipped with a front matter that tells Jekyll what template apply to its body and sets the variables parametrizing process of conversion.
Please watch [Mike Dane's Tutorial on Jekyll's front matter](https://www.youtube.com/watch?v=ZtEbGztktvc&list=PLLAZ4kZ9dFpOPV5C5Ay0pHaa0RJFhcmcB&index=7).
Here you can find available [page layouts](https://mmistakes.github.io/minimal-mistakes/docs/layouts/) `Minimum Mistakes` theme.
The simplest method to start is to add your content to folder `_posts`.
Filename of each post should start with date of its creation, so please stick to this convection.
In a front matter of the post you can set not only its title, but also assign category and mark it with tags.
The template has pages that display posts sorted according to the introduced by you taxonomy.
Your only task is to refer them in the definition of the navigation bar (`_data/navigation.yml`)
In a body of the post you can place text, mathematical expressions, images and videos.
[This explanation of theme helpers](https://mmistakes.github.io/minimal-mistakes/docs/helpers/) demonstrates how to do it efficiently.
Jekyll also can handle collections other than posts.
They can be organized as independent units (like `Recipes` in this template) or be the fragments of some larger structure (for instance provided sample tutorials can be chapters of a book).
Unfortunately, Jekyll is a blog aware system, so posts are special collection.
As a consequence, taxonomy does not work for other collections.
Harmonization of all collection types in planned in version 4.x.
Please refer to [theme's Quick Start guide}(https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/) for more in-depth information.

Happy authoring.

