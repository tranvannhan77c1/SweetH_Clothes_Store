angular.module('app')
    .service('AccountService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/accounts';

        var loginToken = localStorage.getItem('jwtToken');

        // Thêm header với token vào tất cả các yêu cầu HTTP
        var config = {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + loginToken.replace(/"/g, '').trim()
            }
        };

        this.getAccountsPage = function(page, size) {
            page = page || 0; // Trang mặc định là 0
            size = size || 8; // Kích thước mặc định là 8

            return $http.get(baseUrl, {
                params: { page: page, size: size },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching accounts', error);
                throw error;
            });
        };

        this.getAccountById = function(id) {
            return $http.get(baseUrl + '/' + id, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching account', error);
                    throw error;
                });
        };

        this.createAccount = function(account) {
            return $http.post(baseUrl, account, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error adding account', error);
                    throw error;
                });
        };

        this.checkUsernameExists = function(username) {
            return $http.get(baseUrl + '/check-username', {
                params: { username: username },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error checking username', error);
                throw error;
            });
        };

        this.checkEmailExists = function(email) {
            return $http.get(baseUrl + '/check-email', {
                params: { email: email },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error checking email', error);
                throw error;
            });
        };

        this.checkPhoneExists = function(phone) {
            return $http.get(baseUrl + '/check-phone', {
                params: { phone: phone },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error checking phone', error);
                throw error;
            });
        };
    }]);
