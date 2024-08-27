angular.module('app')
    .service('ItemService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/items';

        var loginToken = localStorage.getItem('jwtToken');

        // Thêm header với token vào tất cả các yêu cầu HTTP
        var config = {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + loginToken.replace(/"/g, '').trim()
            }
        };

        this.getItemsPage = function(page, size) {
            page = page || 0;
            size = size || 8;

            return $http.get(baseUrl, {
                params: { page: page, size: size },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching items', error);
                throw error;
            });
        };

        this.getAllItems = function() {
            return $http.get(baseUrl + '/all', config)
                .then(function(response) {
                    return response.data;
                }).catch(function(error) {
                    console.error('Error fetching items', error);
                    throw error;
                });
        };

        this.getItemById = function(id) {
            return $http.get(baseUrl + '/' + id, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching item', error);
                    throw error;
                });
        };

        this.createItem = function(item) {
            return $http.post(baseUrl, item, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error creating item', error);
                    throw error;
                });
        };

        this.updateItem = function(id, item) {
            return $http.put(baseUrl + '/' + id, item, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating item', error);
                    throw error;
                });
        };

        this.deleteItem = function(id) {
            return $http.delete(baseUrl + '/' + id, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error deleting item', error);
                    throw error;
                });
        };

        this.checkName = function(name, excludeId) {
            return $http.get(baseUrl + '/check-name', {
                params: { name: name },
                headers: config.headers
            }).then(response => response.data);
        };
    }]);
