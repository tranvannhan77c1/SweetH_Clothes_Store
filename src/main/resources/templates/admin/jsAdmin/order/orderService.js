angular.module('app')
    .service('OrderService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/orders';

        var loginToken = localStorage.getItem('jwtToken');

        // Thêm header với token vào tất cả các yêu cầu HTTP
        var config = {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + loginToken.replace(/"/g, '').trim()
            }
        };

        this.getOrdersPage = function(page, size) {
            page = page || 0;
            size = size || 8;

            return $http.get(baseUrl, {
                params: { page: page, size: size },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching orders', error);
                throw error;
            });
        };

        this.getOrderDetails = function(orderId) {
            return $http.get(baseUrl+ '/' + orderId, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching order details', error);
                    throw error;
                });
        };

        this.updateOrderStatus = function(orderId, status) {
            return $http.put(baseUrl + '/' + orderId + '/status', status, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating order status', error);
                    throw error;
                });
        };
    }]);
