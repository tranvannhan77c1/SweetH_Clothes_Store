angular.module('app')
    // .service('OrdersService', ['$http', function($http) {

    //     // Function để lấy danh sách đơn hàng từ API
    //     this.getAllOrders = function(page, size) {
    //         page = page || 0; // Trang mặc định là 0
    //         size = size || 8; // Kích thước mặc định là 5

    //         return $http.get('http://localhost:8080/api/orders', {
    //             params: { page: page, size: size }
    //         }).then(function(response) {
    //             return response.data;
    //         }).catch(function(error) {
    //             console.error('Error fetching orders', error);
    //             throw error;
    //         });
    //     };

    // }]);

    .service('OrdersService', ['$http', function($http) {

        this.getAllOrders = function(page, size) {
            page = page || 0; // Trang mặc định là 0
            size = size || 8; // Kích thước mặc định là 5

            return $http.get('http://localhost:8080/api/orders', {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching orders', error);
                throw error;
            });
        };

        this.getOrderDetails = function(orderId) {
            return $http.get('http://localhost:8080/api/orders/' + orderId)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching order details', error);
                    throw error;
                });
        };
    }]);
