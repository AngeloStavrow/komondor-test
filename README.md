# Testing Komondor in Xcode 11 for iOS 13 apps

The goal is to get Komondor automating some things on pre-commit and pre-push git hooks. Followed the "Xcode only install" documentation [here](https://github.com/shibapm/Komondor/blob/master/Documentation/only_xcode.md); see the commit history for step-by-step file additions.

Installing Komondor's git-hooks appeared to work as expected:

```
$ swift run komondor install
Fetching https://github.com/shibapm/Komondor.git
Fetching https://github.com/JohnSundell/ShellOut.git
Fetching https://github.com/shibapm/PackageConfig
Completed resolution in 3.41s
Cloning https://github.com/shibapm/PackageConfig
Resolving https://github.com/shibapm/PackageConfig at 0.10.0
Cloning https://github.com/JohnSundell/ShellOut.git
Resolving https://github.com/JohnSundell/ShellOut.git at 2.2.0
Cloning https://github.com/shibapm/Komondor.git
Resolving https://github.com/shibapm/Komondor.git at 1.0.4
/Users/Angelo/Developer/DroppedBits/experiments/komondor-test/.build/checkouts/PackageConfig/Sources/PackageConfig/Package.swift:60:12: warning: needs to be improved
#warning("needs to be improved")
^~~~~~~~~~~~~~~~~~~~~~
/Users/Angelo/Developer/DroppedBits/experiments/komondor-test/.build/checkouts/PackageConfig/Sources/PackageConfig/Package.swift:61:12: warning: consider adding `/usr/lib` to libPath maybe
#warning("consider adding `/usr/lib` to libPath maybe")
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/Users/Angelo/Developer/DroppedBits/experiments/komondor-test/.build/checkouts/PackageConfig/Sources/PackageConfig/Package.swift:104:12: warning: TODO: handle //swift-tools-version:4.2 declarations
#warning("TODO: handle //swift-tools-version:4.2 declarations")
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/Users/Angelo/Developer/DroppedBits/experiments/komondor-test/.build/checkouts/PackageConfig/Sources/PackageConfig/DynamicLibraries.swift:46:37: warning: 'encodedOffset' is deprecated: encodedOffset has been deprecated as most common usage is incorrect. Use utf16Offset(in:) to achieve the same behavior.
return String($0.prefix(comment.encodedOffset))
^
/Users/Angelo/Developer/DroppedBits/experiments/komondor-test/.build/checkouts/PackageConfig/Sources/PackageConfig/DynamicLibraries.swift:46:37: warning: 'encodedOffset' is deprecated: encodedOffset has been deprecated as most common usage is incorrect. Use utf16Offset(in:) to achieve the same behavior.
return String($0.prefix(comment.encodedOffset))
^
[5/5] Linking ./.build/x86_64-apple-macosx/debug/komondor
[Komondor] git-hooks installed
```

Then we try to get the pre-commit hook to run. Check to make sure there are files to commit:

```
$ git status
On branch master
Changes not staged for commit:
(use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)

modified:   Package.swift

Untracked files:
(use "git add <file>..." to include in what will be committed)

Package.resolved

no changes added to commit (use "git add" and/or "git commit -a")
```

Add the files:

```
$ git add .
```

So far so good. Try to commit the files and things explode:

```
$ git commit -S -m "Added Komondor"
Package.swift:18:32: error: missing argument label 'from:' in call
let config = PackageConfig([
^
from: 
Fatal error: Error raised at top level: PackageConfig.Error(reason: "Could not find a file at /var/folders/m1/b28b8ykj62x8d2_syqh6336w0000gp/T/package-config - something went wrong with compilation step probably"): file /BuildRoot/Library/Caches/com.apple.xbs/Sources/swiftlang/swiftlang-1001.8.63.13/swift/stdlib/public/core/ErrorType.swift, line 200
.git/hooks/pre-commit: line 21: 18454 Illegal instruction: 4  $komondor run pre-commit
```

So this is where I'm now stuck.
