AuthControllerLogin = ['$scope', '$state', '$auth', ($scope, $state, $auth) ->

	$auth.logout();
	
	$scope.user = {}
	$scope.login = () ->
		success = () ->
			$state.transitionTo('app.home');
		fail = () ->
			alert 'Error';
		$auth.login $scope.user
			.then success, fail;
]

angular.module 'app'
	.controller 'AuthController.login', AuthControllerLogin;
