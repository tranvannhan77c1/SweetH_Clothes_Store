angular.module('app')
    .service('VoucherService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/vouchers';

        this.getAllVouchersPage = function(page, size) {
            page = page || 0; // Trang mặc định là 0
            size = size || 8; // Kích thước mặc định là 8

            return $http.get(baseUrl, {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching vouchers', error);
                throw error;
            });
        };

        this.getAllVouchers = function() {
            return $http.get(baseUrl + '/all')
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching vouchers', error);
                    throw error;
                });
        };

        this.getVoucherById = function(id) {
            return $http.get(baseUrl + '/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching voucher', error);
                    throw error;
                });
        };

        this.createVoucher = function(voucher) {
            return $http.post(baseUrl, voucher)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error creating voucher', error);
                    throw error;
                });
        };

        this.updateVoucher = function(id, voucher) {
            return $http.put(baseUrl + '/' + id, voucher)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating voucher', error);
                    throw error;
                });
        };

        this.deleteVoucher = function(id) {
            return $http.delete(baseUrl + '/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error deleting voucher', error);
                    throw error;
                });
        };
    }]);
