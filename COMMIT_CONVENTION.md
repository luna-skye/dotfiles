Commit Message Guidelines
==========================
These guidelines were pulled from the source listed below, and has been through a few revisions since then. This particular iteration includes information specific to [Luna Skye's Dotfiles](https://gitlab.com/luna-skye/dotfiles) repo, so it may not apply to other git projects.<br>
Thanks to @stephenparish for [the original text](https://gist.github.com/stephenparish/9941e89d80e2bc58a153)

In the last few years, the number of programmers concerned about writting structured commit messages has dramatically grown. As exposed by Tim Pope in [article](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html), readable commit messages are easy to follow when looking through the project history. Moreover [the AngularJS contributing guides](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md) introduced conventions that can be used by automation tools to automatically generate useful documentation, or by developpers during debugging process.

This document borrows some concepts, conventions and even text mainly from these two sources, extending them in order to provide a sensible guideline for writing commit messages.

* [Goals](#goals)
* [Proposal](#proposal)
  - [Commit Message Format](#commit-message-format)
    + [Allowed `<type>`](#allowed-type)
    + [Allowed `<scope>`](#allowed-scope)
    + [`<subject>` text](#subject-text)
    + [Allowed `<meta>`](#allowed-meta)
    + [Message body](#message-body)
    + [Message footer](#message-footer)
      - [Breaking changes](#breaking-changes)
      - [Referencing issues](#referencing-issues)
  * [Examples](#examples)
  * [Revert](#revert)
* [Generating CHANGELOG.md](#generating-changelogmd)

Goals
-----
* allow generating CHANGELOG.md by script
* allow ignoring commits by git bisect (not important commits like formatting)
* provide better information when browsing the history

Motivation
----------
Consider the following commit messages:

* fix comment stripping
* fixing broken links
* Bit of refactoring
* Check whether links do exist and throw exception
* Fix sitemap include (to work on case sensitive linux)
* Fix small typo in docs widget (tutorial instructions)
* Fix test for scenario.Application - should remove old iframe
* docs - various doc fixes
* docs - stripping extra new lines
* Replaced double line break with single when text is fetched from Google
* Added support for properties in documentation

On the one hand, looking at the first 5 messages is not possible to identify which part of the code had changed. (The remaining messages try to specify where the change is, but they don’t share any convention...)

On the other hand, commits introducing formatting changes (adding/removing spaces/empty lines, indentation), missing semi colons, comments, etc are not interesting to debug code or to documenting changes, since no logic change inside them.

Although it is possible to find more information by checking which files had been changed and performing some diffs, it is not practical when looking in git history.

Structural conventions can speed up this process, by allowing filtering. For example, when bisecting, you can ignore files by doing:
```bash
git bisect skip $(git rev-list --grep irrelevant <good place> HEAD)
```

---

Proposal
--------
### Commit Message Format

```xml
<type>(<scope>): <subject> <meta>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

Any line of the commit message cannot be longer 100 characters! This allows the message to be easier to read on GitHub as well as in various git tools.

> Subject line may be prefixed for continuous integration purposes.
> For example, [JIRA](https://bigbrassband.com/git-for-jira.html)
> requires ticket in the beggining of commit message message:
> "[LHJ-16] fix(compile): add unit tests for windows"

#### Allowed `<type>`
* **feat**: A new feature or addition
* **fix**: A bug fix
* **docs**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **perf**: A code change that improves performance
* **test**: Adding missing tests
* **workflow**: Alters the workflow or developer experience
* **chore**: Changes to the build process, libraries, or maintenance related tasks

#### Allowed `<scope>`
Commit scope in the context of our dotfiles repo refers to a slash separated list of two values, `home` vs. `sys` scope, followed by the most relevant directory scope.

Here are some examples:
* **sys/core**: global system modules
* **sys/gaming**: opt-in system module called `gaming`
* **sys/luna**: host specific configuration
* **home/core**: global home-manager modules
* **home/hyprland**: opt-in home-manager module called `hyprland`
* **home/skye**: user specific config within home-manager


#### `<subject>` text
Subject line should contains succinct description of the change. 

* use imperative, present tense: “change” not “changed” nor “changes”
* not over 100 characters in length
* don't capitalize first letter
* no dot (.) at the end

#### Allowed `<meta>`
Additionally, the end of subject-line may contain twitter-inspired markup to facilitate changelog generation and bissecting.

* `#wip` - indicate for contributors the feature being implemented is not complete yet. Should not be included in changelogs (just the last commit for a feature goes to the changelog).
* `#irrelevant` - the commit does not add useful information. Used when fixing typos, etc... Should not be included in changelogs.

#### Message body
* just as in `<subject>` use imperative, present tense: “change” not “changed” nor “changes”
* includes motivation for the change and contrasts with previous behavior

http://365git.tumblr.com/post/3308646748/writing-git-commit-messages
http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

#### Message footer

##### Breaking changes
All breaking changes have to be mentioned in footer with the description of the change, justification and migration notes

```
BREAKING CHANGE: isolate scope bindings definition has changed and
    the inject option for the directive controller injection was removed.

    To migrate the code follow the example below:

    Before:

    scope: {
      myAttr: 'attribute',
      myBind: 'bind',
      myExpression: 'expression',
      myEval: 'evaluate',
      myAccessor: 'accessor'
    }

    After:

    scope: {
      myAttr: '@',
      myBind: '@',
      myExpression: '&',
      // myEval - usually not useful, but in cases where the expression is assignable, you can use '='
      myAccessor: '=' // in directive's template change myAccessor() to myAccessor
    }

    The removed `inject` wasn't generaly useful for directives so there should be no code using it.
```

##### Referencing issues
Closed bugs should be listed on a separate line in the footer prefixed with "Closes" keyword like this:
```
Closes #234
```

or in case of multiple issues:
```
Closes #123, #245, #992
```

### Revert

If the commit reverts a previous commit, it should begin with revert:, followed by the header of the reverted commit. In the body it should say: This reverts commit <hash>., where the hash is the SHA of the commit being reverted.

### Examples
```
feat($browser): add onUrlChange event (popstate/hashchange/polling)

New $browser event:
- forward popstate event if available
- forward hashchange event if popstate not available
- do polling when neither popstate nor hashchange available

Breaks $browser.onHashChange, which was removed (use onUrlChange instead)
```

```
fix($compile): add unit tests for IE9

Older IEs serialize html uppercased, but IE9 does not...
Would be better to expect case insensitive, unfortunately jasmine does
not allow to user regexps for throw expectations.

Closes #392
Breaks foo.bar api, foo.baz should be used instead
```

```
feat(directive): add directives disabled/checked/multiple/readonly/selected

New directives for proper binding these attributes in older browsers (IE).
Added coresponding description, live examples and e2e tests.

Closes #351
```

```
style($location): add couple of missing semi colons
```

```
docs(guide): update fixed docs from Google Docs

Couple of typos fixed:
- indentation
- batchLogbatchLog -> batchLog
- start periodic checking
- missing brace
```

```
feat($compile): simplify isolate scope bindings

Change the isolate scope binding options to:
  - @attr - attribute binding (including interpolation)
  - =model - by-directional model binding
  - &expr - expression execution binding

This change simplifies the terminology as well as
number of choices available to the developer. It
also supports local name aliasing from the parent.

BREAKING CHANGE: isolate scope bindings definition has changed and
the inject option for the directive controller injection was removed.

To migrate the code follow the example below:

Before:

scope: {
  myAttr: 'attribute',
  myBind: 'bind',
  myExpression: 'expression',
  myEval: 'evaluate',
  myAccessor: 'accessor'
}

After:

scope: {
  myAttr: '@',
  myBind: '@',
  myExpression: '&',
  // myEval - usually not useful, but in cases where the expression is assignable, you can use '='
  myAccessor: '=' // in directive's template change myAccessor() to myAccessor
}

The removed `inject` wasn't generaly useful for directives so there should be no code using it.
```

Generating CHANGELOG.md
-----------------------
Changleos may contain three sections: new features, bug fixes, breaking changes.
This list could be generated by script when doing a release, along with links to related commits.
Of course you can edit this change log before actual release, but it could generate the skeleton.

List of all subjects (first lines in commit message) since last release:
```bash
git log <last tag> HEAD --pretty=format:%s
```

New features in this release
```bash
git log <last release> HEAD --grep feat
```
