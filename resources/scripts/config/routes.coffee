angular.module 'app'
	.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
		$stateProvider.state 'app', {
			abstract: true,
			templateUrl: 'build/views/layouts/default.html'
		}
		.state 'app.login', {
			url: '/login',
			controller: 'AuthController.login',
			templateUrl: 'build/views/auth/login.html',
		}
		.state 'app.register', {
			url: '/register',
			templateUrl: 'build/views/auth/register.html',
		}
		.state 'app.home', {
			url: '/',
			controller: 'HomeController',
			templateUrl: 'build/views/home/home.html'
		}

		$urlRouterProvider.otherwise '/';
	]