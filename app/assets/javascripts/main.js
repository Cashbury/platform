App = Ember.Application.create({
  LOG_TRANSITIONS: true
});

DS.RESTAdapter.configure("plurals", {
  business: "businesses"
});

App.Store = DS.Store.extend({
  revision: 12,
  adapter: DS.RESTAdapter.extend({
    namespace: 'api/v1'
  })
});

App.Auth = Ember.Auth.create({
  modules: ['emberData',
            'rememberable',
            'authRedirectable',
            'actionRedirectable',
            'urlAuthenticatable'
            ],
  signInEndPoint: '/api/v1/sessions',
  signOutEndPoint: '/api/v1/sessions',
  tokenKey: 'authentication_token',
  tokenIdKey: 'user_id',
  userModel: 'App.User',
  rememberable: {
    tokenKey: 'remember_token',
    period: 14,
    autoRecall: true
  },
  authRedirectable: {
    route: 'sign_in'
  },
  actionRedirectable: {
    signInRoute: 'index',
    signOutRoute: 'index'
  },
  urlAuthenticatable: {
    paramsKey: 'auth'
  }
});

App.Business = DS.Model.extend({
  name:         DS.attr('string'), 
  legal_name:   DS.attr('string'),
  description:  DS.attr('string'),
  featured:     DS.attr('boolean')
});

App.Router.map(function() {
  this.route('sign_in');
  this.route('sign_out');
  this.route('business');
});

App.IndexRoute = Ember.Route.extend({
  model: function(params) {
    if (App.Auth.signedIn) {
      return App.Business.find(3);
    }
  },

  setupController: function(controller, model) {
    debugger;
    controller.set('model', model);
  }
});

App.ApplicationController = Ember.Controller.extend({
  signOut: function() {
    App.Auth.signOut();
  }
});

App.SignInRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this.controllerFor('application').set('currentRoute', 'sign_in');
  }
});

App.Location = DS.Model.extend({});
App.PrizeBoard = DS.Model.extend({
  group:  DS.attr('group'),
  icon1:  DS.attr('icon1'),
  icon2:  DS.attr('icon2')
});

App.SignInController = Ember.Controller.extend({
  email: null,
  password: null,
  remember: false,
  loginError: false,
  loginResponse: "",
  signIn: function() {
    App.Auth.signIn({
      data: {
        'email': this.get('email'),
        'password': this.get('password')
      }
    });
    var self = this;
    App.Auth.on('signInError', function() {
      self.set('loginError', true);
      self.set('loginResponse', JSON.parse(App.Auth.get('jqxhr').responseText).errors[0]);
    });
    App.Auth.on('signInSuccess', function() {
      self.set('loginError', false);
    });
  },
  dismissError: function() {
    this.set('loginError', false);
  }
});