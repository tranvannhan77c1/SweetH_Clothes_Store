var app = angular.module('categoryApp', []);

app.controller('ProductController', ['$scope', '$http', function($scope, $http) {
    $scope.products = [];

    $http.get('http://localhost:8080/api/v1/product/landing?page=5&limit=8')
        .then(function(response) {
            $scope.products = response.data.content;
        })
        .catch(function(error) {
            console.error('Error fetching products:', error);
        });
}]);