# Superfluous Disable Command

SwiftLint 'disable' commands are superfluous when the disabled rule would not have triggered a violation in the disabled region. Use " - " if you wish to document a command.

* **Identifier:** superfluous_disable_command
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning