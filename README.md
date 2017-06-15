Supress Users In ArchivesSpace
=====================================

This plug-in allows you to deactivate users in ArchivesSpace. Deactived users
will still have accounts, but by default will not show-up in the users list.
There is an options to show hidden user accounts in the users list. 

Deactivated users will also not be allowed to log-in. You cannot deactive the
original "Adminstrator" user.

**To use with ArchivesSpace you must add the plugin to your config.rb:**

```
AppConfig[:plugins] << 'aspace_suppress_users'
```
