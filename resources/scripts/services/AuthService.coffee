AuthService = ['$http', '$q', '$cookies', '$config', ($http, $q, $cookies, $config) ->
	auth = {

		user: null,

		login: ( credentials ) ->

			deferred = $q.defer();

			success = ( response ) ->
				auth.setToken response.data.token;
				auth.setUser response.data.user;
				deferred.resolve response.data.user;

			fail = ( error ) ->
				auth.removeToken();
				deferred.reject error;

			$http.post $config.api.url + "/auth/login", credentials
				.then success, fail

			deferred.promise;

		setToken: ( token ) ->
			$cookies.put 'api-token', token;

		getToken: () ->
			$cookies.get 'api-token';

		removeToken: () ->
			$cookies.remove 'api-token';

		logout: () ->
			$http.get $config.api.url + "/auth/logout"

		setUser: ( user ) ->
			auth.user = user;

		getUser: () ->
			deferred = $q.defer();

			if auth.user
				deferred.resolve auth.user;
			else
				$http.get $config.api.url + "/auth/logged"
					.then (( response ) -> deferred.resolve response.data; auth.setUser response.data), (( error ) -> deferred.reject error);

			deferred.promise;
	}
	auth;
]

angular.module 'app'
	.service '$auth', AuthService;