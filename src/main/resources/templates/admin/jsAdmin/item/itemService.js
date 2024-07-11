angular.module('app')
    .service('ItemService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/items';

        this.getAllItemsPage = function(page, size) {
            page = page || 0; // Trang mặc định là 0
            size = size || 8; // Kích thước mặc định là 8

            return $http.get(baseUrl, {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching items', error);
                throw error;
            });
        };

        this.getAllItems = function() {
            return $http.get(baseUrl + '/all', {
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching items', error);
                throw error;
            });
        };

        this.getItemById = function(id) {
            return $http.get(baseUrl + '/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching item', error);
                    throw error;
                });
        };

        this.createItem = function(item) {
            return $http.post(baseUrl, item)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error creating item', error);
                    throw error;
                });
        };

        this.updateItem = function(id, item) {
            return $http.put(baseUrl + '/' + id, item)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating item', error);
                    throw error;
                });
        };

        this.deleteItem = function(id) {
            return $http.delete(baseUrl + '/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error deleting item', error);
                    throw error;
                });
        };
    }]);
