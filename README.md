# AWS WorkSpaces - Onboarding #
- [AWS WorkSpaces - Onboarding](#aws-workspaces---onboarding)
- [Prerequisities](#prerequisities)
- [Onboarding new users to AD and creating their AWS WorkSpace](#onboarding-new-users-to-ad-and-creating-their-aws-workspace)
- [Offboarding users to AD and deleting their AWS WorkSpace](#offboarding-users-to-ad-and-deleting-their-aws-workspace)
- [Preparing a new AD environment](#preparing-a-new-ad-environment)

Prerequisities
==============================

Run `aws configure sso`

  - Select the default SSO session name.
  - When it opens the browser, authenticate with your CAC.
  - Once authenticated, return to the CLI.
  - Select `<AWS ACCOUNT>`.
  - Select `<AWS FEDERATED ROLE>`.
  - Leave the Region as default.
  - Leave the output format as default.
  - Set the Profile name to `default`.


Onboarding new users to AD and creating their AWS WorkSpace
==============================

Update users/users.csv with the necessary information for new users.


Run the `create_users.ps1` script.

This will create an AD user account and AWS WorkSpace for any new additions to the CSV.


Offboarding users to AD and deleting their AWS WorkSpace
==============================

Update users/deleteusers.csv with the necessary information for offboarded users.

Run the `delete_users.ps1` script.

This will remove their AD user account and AWS WorkSpace.

Preparing a new AD environment
==============================

If this is a new Active Directory deployment being leveraged for AWS Workspaces, please go through the scripts within the new_directory_onboarding folder in order to prepare the environment before onboarding users.