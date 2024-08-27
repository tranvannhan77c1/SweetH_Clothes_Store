angular.module('app')
    .service('VoucherService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/vouchers';

        var loginToken = localStorage.getItem('jwtToken');

        // Thêm header với token vào tất cả các yêu cầu HTTP
        var config = {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + loginToken.replace(/"/g, '').trim()
            }
        };

        this.getAllVouchersPage = function(page, size) {
            page = page || 0; // Trang mặc định là 0
            size = size || 8; // Kích thước mặc định là 8

            return $http.get(baseUrl, {
                params: { page: page, size: size },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching vouchers', error);
                throw error;
            });
        };

        this.getAllVouchers = function() {
            return $http.get(baseUrl + '/all', config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching vouchers', error);
                    throw error;
                });
        };

        this.getVoucherById = function(id) {
            return $http.get(baseUrl + '/' + id, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching voucher', error);
                    throw error;
                });
        };

        this.createVoucher = function(voucher) {
            return $http.post(baseUrl, voucher, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error creating voucher', error);
                    throw error;
                });
        };

        this.updateVoucher = function(id, voucher) {
            return $http.put(baseUrl + '/' + id, voucher, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating voucher', error);
                    throw error;
                });
        };

        this.deleteVoucher = function(id) {
            return $http.delete(baseUrl + '/' + id, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error deleting voucher', error);
                    throw error;
                });
        };

        this.checkVoucherCode = function(code, excludeId) {
            return $http.get(baseUrl + '/check-code', {
                params: { code: code, excludeId: excludeId },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error checking voucher code', error);
                throw error;
            });
        };
    }]);
