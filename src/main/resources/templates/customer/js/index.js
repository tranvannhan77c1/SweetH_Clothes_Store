var app = angular.module('indexApp', []);

app.controller('ProductController', ['$scope', '$http', function($scope, $http) {
    $scope.products = [];

    $http.get('http://localhost:8080/api/v1/product/landing?page=5&limit=8')
        .then(function(response) {
            $scope.products = response.data.content;
            console.log(response.data.content[0].thumbnailImage)
        })
        .catch(function(error) {
            console.error('Error fetching products:', error);
        });
}]);