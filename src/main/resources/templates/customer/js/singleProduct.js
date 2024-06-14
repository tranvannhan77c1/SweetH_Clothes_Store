var app = angular.module('singleProductApp', []);

    app.controller('SingleProductController', ['$scope', '$http', '$location', function($scope, $http, $location) {
        // Function to get query parameters
        function getQueryParams() {
            var params = {};
            var parts = $location.absUrl().split('?')[1].split('&');
            for (var i = 0; i < parts.length; i++) {
                var param = parts[i].split('=');
                params[param[0]] = param[1];
            }
            return params;
        }

        // Get product ID from URL
        var params = getQueryParams();
        var productId = params['id'];

        // Fetch product details from the API
        $http.get('http://localhost:8080/api/v1/product/' + productId)
            .then(function(response) {
                $scope.product = response.data;
            })
            .catch(function(error) {
                console.error('Error fetching product data:', error);
            });
    }]);