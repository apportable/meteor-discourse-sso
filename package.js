Package.describe({
  summary: "Single sign-on for Discourse forums"
});

Package.on_use(function (api) {
  var both = ['client', 'server']

  api.use('coffeescript', both);
  api.use('iron-router', 'client');
  api.use('minimongoid', 'server');
  api.use('underscore', 'server')

  api.add_files('router.coffee', 'client');
  api.add_files('methods.coffee', 'server');
  api.add_files('sso.coffee', 'server');
});
