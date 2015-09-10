angular.module 'app', ['ui.router', 'ngCookies']
	.config ['$locationProvider', '$httpProvider', ($locationProvider, $httpProvider)->
		
		$locationProvider.html5Mode true;

		$httpProvider.interceptors.push ['$q', '$injector', ($q, $injector) ->
			{
				'request': ( config ) ->
					$auth = $injector.get '$auth';
					config.headers['Api-Token'] = $auth.getToken();
					config;

				'responseError': ( reject ) ->
					if reject && reject.status == 401
						$state = $injector.get '$state';
						$state.transitionTo 'app.login';

					$q.reject( reject );
			}
		]
	]