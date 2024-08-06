angular.module('app')
    .service('CategoryService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/categories';

        this.getAllCategories = function(page, size) {
            page = page || 0; // Trang mặc định là 0
            size = size || 8; // Kích thước mặc định là 8

            return $http.get(baseUrl, {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching categories', error);
                throw error;
            });
        };

        this.getCategoryById = function(id) {
            return $http.get(baseUrl + '/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching category', error);
                    throw error;
                });
        };

        this.createCategory = function(category) {
            return $http.post(baseUrl, category)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error creating category', error);
                    throw error;
                });
        };

        this.updateCategory = function(id, category) {
            return $http.put(baseUrl + '/' + id, category)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating category', error);
                    throw error;
                });
        };

        this.deleteCategory = function(id) {
            return $http.delete(baseUrl + '/' + id)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error deleting category', error);
                    throw error;
                });
        };

        this.checkCategoryName = function(name, excludeId) {
            return $http.get(baseUrl + '/check-name', {
                params: { name: name, excludeId: excludeId }
            }).then(response => response.data);
        };

    }]);
