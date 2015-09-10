HomeController = ['$scope', '$auth', ($scope, $auth) ->
	$auth.getUser().then (user) ->
		$scope.user = user;
]

angular.module 'app'
	.controller 'HomeController', HomeController;