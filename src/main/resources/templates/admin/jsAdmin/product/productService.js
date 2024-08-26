angular.module('app')
    .service('ProductService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/products';

        this.getProductsPage = function(page, size) {
            page = page || 0;
            size = size || 5;

            return $http.get(baseUrl, {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching products', error);
                throw error;
            });
        };

        this.getAllProducts = function() {
            return $http.get(baseUrl + '/all')
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching products', error);
                    throw error;
                });
        };

        this.getProductById = function(id) {
            return $http.get(baseUrl + '/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching product', error);
                    throw error;
                });
        };

        this.createProduct = function(product) {
            return $http.post(baseUrl, product)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error creating product', error);
                    throw error;
                });
        };

        this.updateProduct = function(id, product) {
            return $http.put(baseUrl + '/' + id, product)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating product', error);
                    throw error;
                });
        };

        this.deleteProduct = function(id) {
            return $http.delete(baseUrl + '/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error deleting product', error);
                    throw error;
                });
        };

        this.checkProductName = function(name, excludeId) {
            return $http.get(baseUrl + '/check-name', {
                params: { name: name, excludeId: excludeId }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error checking voucher code', error);
                throw error;
            });
        };
    }]);
