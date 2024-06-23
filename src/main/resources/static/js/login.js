window.onload=function() {
	var app = angular.module('loginApp', []);

	app.controller('loginController', ['$scope', '$http', function($scope, $http) {
    $scope.cart = [];
    

    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }
	}]);
}