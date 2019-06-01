# 🍫 choco_search
A simple command-line tool for searching through Chocolatey packages through the terminal. The goal is to provide a better experience than that of Chocolatey's `choco search` command.

## Installation
1) Install the Dart SDK
2) Clone repository
3) Add alias, e.g. "alias choco_search="dart ~/choco_search/bin/main.dart"

## Uses
`$ choco_search vscode`


>Package: vscode | Version: 1.34.0 | Downloads: 421,118 downloads  
Install: 'choco install vscode'

>Package: VisualStudioCode | Version: 1.23.1.20180730 | Downloads: 651,645 downloads  
Install: 'choco install visualstudiocode'

>Package: vscode-powershell | Version: 1.0.0.20181011 | Downloads: 46,694 downloads  
Install: 'choco install vscode-powershell'

>Package: vscode-csharp | Version: 1.0.0.20181011 | Downloads: 37,978 downloads  
Install: 'choco install vscode-csharp'

>Package: vscode-icons | Version: 1.0.0.20190314 | Downloads: 36,037 downloads  
Install: 'choco install vscode-icons'

`$ choco_search git --desc`

>Package: git  
Version: 2.21.0  
Downloads: 2,696,358 downloads  
Install: "choco install git"  
Description:  
Git for Windows focuses on offering a lightweight, native set of tools that bring the full feature set of the Git SCM to Windows while providing appropriate user interfaces for experienced Git users and novices alike.

`choco_search jdk8 --open`

*Will open the a browser window with the given package*