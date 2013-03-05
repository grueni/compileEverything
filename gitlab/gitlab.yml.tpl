# # # # # # # # # # # # # # # # # # 
# GitLab application config file  #
# # # # # # # # # # # # # # # # # #
#
# How to use:
# 1. copy file as gitlab.yml
# 2. Replace gitlab -> host with your domain
# 3. Replace gitlab -> email_from

production: &base
  #
  # 1. GitLab app settings
  # ==========================

  ## GitLab settings
  gitlab:
    ## Web server settings
    host: localhost
    port: @PORT_HTTPS_GITLAB@
    https: true
    # Uncomment and customize to run in non-root path
    # Note that ENV['RAILS_RELATIVE_URL_ROOT'] in config/unicorn.rb may need to be changed
    relative_url_root: /gitlab

    # Uncomment and customize if you can't use the default user to run GitLab (default: 'git')
    user: @USERNAME@

    ## Email settings
    # Email address used in the "From" field in mails sent by GitLab
    email_from: gitoliteadm@mail.com

    # Email address of your support contact (default: same as email_from)
    # support_email: support@localhost

    ## Project settings
    default_projects_limit: 10
    # signup_enabled: true          # default: false - Account passwords are not sent via the email if signup is enabled.
    # username_changing_enabled: false # default: true - User can change her username/namespace


  ## External issues trackers
  issues_tracker:
    redmine:
      ## If not nil, link 'Issues' on project page will be replaced with this
      ## Use placeholders:
      ##  :project_id        - GitLab project identifier
      ##  :issues_tracker_id - Project Name or Id in external issue tracker
      # project_url: "http://redmine.sample/projects/:issues_tracker_id"
      ## If not nil, links from /#\d/ entities from commit messages will replaced with this
      ## Use placeholders:
      ##  :project_id        - GitLab project identifier
      ##  :issues_tracker_id - Project Name or Id in external issue tracker
      ##  :id                - Issue id (from commit messages)
      # issues_url: "http://redmine.sample/issues/:id"

  ## Gravatar
  gravatar:
    enabled: true                 # Use user avatar image from Gravatar.com (default: true)
    # plain_url: "http://..."     # default: http://www.gravatar.com/avatar/%{hash}?s=%{size}&d=mm
    # ssl_url:   "https://..."    # default: https://secure.gravatar.com/avatar/%{hash}?s=%{size}&d=mm



  #
  # 2. Auth settings
  # ==========================

  ## LDAP settings
  ldap: 
    enabled: true
    host: '@LDAP_HOSTNAME@'
    base: '@LDAP_BASE@'
    port: @LDAP_PORT@
    uid: '@LDAP_UID@'
    method: '@LDAP_METHOD_NC@' # "ssl" or "plain"
    bind_dn: '@LDAP_BINDDN@'
    password: '@LDAP_PASSWORD@'

  ## OmniAuth settings
  omniauth:
    # Allow login via Twitter, Google, etc. using OmniAuth providers
    enabled: false

    # CAUTION!
    # This allows users to login without having a user account first (default: false).
    # User accounts will be created automatically when authentication was successful.
    allow_single_sign_on: false
    # Locks down those users until they have been cleared by the admin (default: true).
    block_auto_created_users: true

    ## Auth providers
    # Uncomment the following lines and fill in the data of the auth provider you want to use
    # If your favorite auth provider is not listed you can use others:
    # see https://github.com/gitlabhq/gitlabhq/wiki/Using-Custom-Omniauth-Providers
    # The 'app_id' and 'app_secret' parameters are always passed as the first two
    # arguments, followed by optional 'args' which can be either a hash or an array.
    providers:
      # - { name: 'google_oauth2', app_id: 'YOUR APP ID',
      #     app_secret: 'YOUR APP SECRET',
      #     args: { access_type: 'offline', approval_prompt: '' } }
      # - { name: 'twitter', app_id: 'YOUR APP ID',
      #     app_secret: 'YOUR APP SECRET'}
      # - { name: 'github', app_id: 'YOUR APP ID',
      #     app_secret: 'YOUR APP SECRET' }



  #
  # 3. Advanced settings
  # ==========================

  # GitLab Satellites
  satellites:
    # Relative paths are relative to Rails.root (default: tmp/repo_satellites/)
    path: @H@/gitlab/gitlab-satellites/

  ## Backup settings
  backup:
    path: "tmp/backups"   # Relative paths are relative to Rails.root (default: tmp/backups/)
    # keep_time: 604800   # default: 0 (forever) (in seconds)

  ## GitLab Shell settings
  gitlab_shell:
    # REPOS_PATH MUST NOT BE A SYMLINK!!!
    repos_path: @H@/repositories/
    hooks_path: @H@/gitlab/gitlab-shell/hooks/

    owner_group: @USERGROUP@

    # Git over HTTP
    upload_pack: true
    receive_pack: true

    # If you use non-standard ssh port you need to specify it
    ssh_port: @PORT_SSHD@

  ## Git settings
  # CAUTION!
  # Use the default values unless you really know what you are doing
  git:
    bin_path: @H@/bin/git
    # Max size of a git object (e.g. a commit), in bytes
    # This value can be increased if you have very large commits
    max_size: 5242880 # 5.megabytes
    # Git timeout to read a commit, in seconds
    timeout: 10


development:
  <<: *base

test:
  <<: *base
  issues_tracker:
    redmine:
      project_url: "http://redmine/projects/:issues_tracker_id"
      issues_url: "http://redmine/:project_id/:issues_tracker_id/:id"

staging:
  <<: *base
