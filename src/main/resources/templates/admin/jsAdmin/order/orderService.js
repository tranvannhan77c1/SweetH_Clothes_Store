angular.module('app')
    .service('OrderService', ['$http', function($http) {

        this.getAllOrders = function(page, size) {
            page = page || 0; // Trang mặc định là 0
            size = size || 8; // Kích thước mặc định là 5

            return $http.get('http://localhost:8080/api/v1/customer/orders', {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching orders', error);
                throw error;
            });
        };

        this.getOrderDetails = function(orderId) {
            return $http.get('http://localhost:8080/api/v1/customer/orders/' + orderId)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching order details', error);
                    throw error;
                });
        };
    }]);
