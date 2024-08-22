angular.module('app')
    .service('OrderService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/orders';

        this.getOrdersPage = function(page, size) {
            page = page || 0;
            size = size || 8;

            return $http.get(baseUrl, {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching orders', error);
                throw error;
            });
        };

        this.getOrderDetails = function(orderId) {
            return $http.get(baseUrl+ '/' + orderId)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching order details', error);
                    throw error;
                });
        };
    }]);
