# CONTRIBUTING

To keep the codebase organized and maintain a clean history, we follow a strict Pull Request workflow.

## Recommended Communication Style

* Always leave screenshots for visuals changes
* Always leave a detailed description in the Pull Request. Leave nothing ambiguous for the reviewer.
* Always review your code first. Do this by leaving comments in your coding noting questions, or interesting things for the reviewer.
* Always communicate. Whether it is in the issue or the pull request, keeping the lines of communication helps everyone around you.


## Workflow

1. **Fork the repository**.

2. **Clone your fork locally**:

    ```bash
    git clone TODO: CHANGE -> git@github.com:your-username/project-name.git
    ```

3. **Add upstream remote**:

    ```bash
    git remote add upstream TODO: CHANGE -> git@github.com:client-username/project-name.git
    git fetch upstream
    ```

4. **Create a new branch** for your work:

    ```bash
    git switch -c feature/your-feature-name
    ```

5. Make your changes **committing small**. Follow the same convention as in the CHANGELOG:

   - `feat:` A new feature
   - `fix:` A bug fix
   - `chores:` Other changes, updates, refactors, or non-feature tasks

6. **Sync your branch with upstream** before creating a PR:

    ```bash
    git fetch upstream
    git switch main
    git merge upstream/main # or `git pull client main`
    git switch feature/your-feature-name
    git rebase main
    ```

    **Note:** Rebase rewrites your branch’s commit history to be on top of the latest main. This keeps the history clean. Do not rebase branches that others are working on.

7. **Install dependencies and check lint** locally before pushing:

    ```bash
    pnpm install
    pnpm lint
    ```

8. **Push your branch** to your fork:

    ```bash
    git push origin feature/your-feature-name
    ```

9. **Open a Pull Request** targeting the `main` branch in the upstream repository.


### PR Validation

* If you've added code that should be tested, add tests.
* If you've changed APIs, update the documentation.
* If you make visual changes, screenshots are required.
* If any, ensure the test suite passes.
* Ensure that you deal with any lint warnings.
* If you refactor the existing code, please let us know in your PR description.
* A PR description and title are required. Make sure to use the commit message convention.
* [Link to an issue](https://help.github.com/en/github/writing-on-github/autolinked-references-and-urls) in the project. Unsolicited code is welcomed, but an issue is required for announce your intentions. PR's without a linked issue will be marked invalid and closed.

Examples for valid PR titles:

- fix: Correct typo.
- feat: Add user authentication feature.
- refactor!: Improve error handling in login module.

_Note that since PR titles only have a single line, you have to use the ! syntax for breaking changes._

See [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for more examples.

## Issues

If you plan to contribute a change based on an open issue, assign yourself. Issues that are not assigned are assumed open, and to avoid conflicts, please assign yourself before beginning work on any issues.

## Notes

- Always pull the latest changes from upstream before starting a new feature.
- PRs should pass all CI/CD checks before merging.
- Keep branches focused on a single feature or fix.
- Avoid pushing directly to main; all changes should go through PRs.

Thank you for helping us keep this project clean and maintainable!
