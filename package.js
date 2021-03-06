Package.describe({
  summary: "Single sign-on for Discourse forums"
});

Package.on_use(function (api) {
  api.use('coffeescript', ['client', 'server']);
  api.use('iron-router', 'client');
  api.use('templating', 'client')
  api.use('jade', 'client');
  api.use('minimongoid', 'server');
  api.use('underscore', 'server')

  api.add_files('router.coffee', 'client');
  api.add_files('discourse_sso.jade', 'client');
  api.add_files('discourse_sso.coffee', 'client');
  api.add_files('methods.coffee', 'server');
  api.add_files('sso.coffee', 'server');
});
