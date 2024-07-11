angular.module('app')
    .service('AccountService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/v1/account';

        this.getAllAccounts = function(page, size) {
            page = page || 0; // Trang mặc định là 0
            size = size || 8; // Kích thước mặc định là 8

            return $http.get(baseUrl, {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching accounts', error);
                throw error;
            });
        };

        this.getAccountById = function(id) {
            return $http.get('http://localhost:8080/api/v1/account/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching account', error);
                    throw error;
                });
        };
        
        // Hàm thêm nhân viên
        this.addEmployee = function(account) {
            return $http.post(baseUrl + '/signup', account)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    throw error;
                });
        };

    }]);
