# CONTRIBUTING

Contributions are always welcome. Before contributing,
please read the [code of conduct](CODE_OF_CONDUCT.md).

Some thoughts to help you contribute to this project

## Recommended Communication Style

* Always leave screenshots for visuals changes
* Always leave a detailed description in the Pull Request. Leave nothing ambiguous for the reviewer.
* Always review your code first. Do this by leaving comments in your coding noting questions, or interesting things for the reviewer.
* Always communicate. Whether it is in the issue or the pull request, keeping the lines of communication helps everyone around you.

## Building

To develop locally, fork the repository and clone it in your local machine. 

```bash
npm i devkit-init
```

If you encounter issues running this script, try granting it execution permissions:

```bash
chmod +x devkit-init.sh
```

## Templates

To add a template, you need to create a directory in /templates by assembling a folder with the suffixes of the names of the technologies you want to use.

The script "devkit-init" is responsible for assembling the path based on those suffixes, taking the user's choices and running the script to which such construction points.

 - Then, we need to create a shell script with the installation of dependencies. 
 - Add another script, .js (which will be run by the previous shell script), will create the custom files we need and update other necessary configurations. 
 - The last file is a .json where we list the files that the .js script is creating. 
 - Take other templates as an example; the names of these three files must be the same as the folder's name.

## Pull Requests

* Fork the repo and create your branch from `main` branch.
* Name your branch something that is descriptive to the work you are doing. i.e. adds-new-thing or fixes-mobile
* If you've added code that should be tested, add tests.
* If you've changed APIs, update the documentation.
* If you make visual changes, screenshots are required.
* Ensure the test suite passes.
* Ensure that you deal with any lint warnings.
* If you refactor the existing code, please let us know in your PR description.
* A PR description and title are required. Make sure to use the commit message convention.
* [Link to an issue](https://help.github.com/en/github/writing-on-github/autolinked-references-and-urls) in the project. Unsolicited code is welcomed, but an issue is required for announce your intentions. PR's without a linked issue will be marked invalid and closed.

### PR Validation

Examples for valid PR titles:

- fix: Correct typo.
- feat: Add user authentication feature.
- refactor!: Improve error handling in login module.

_Note that since PR titles only have a single line, you have to use the ! syntax for breaking changes._

See [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for more examples.

## Issues

If you plan to contribute a change based on an open issue, assign yourself. Issues that are not assigned are assumed open, and to avoid conflicts, please assign yourself before beginning work on any issues.

Also, all questions are welcomed.
