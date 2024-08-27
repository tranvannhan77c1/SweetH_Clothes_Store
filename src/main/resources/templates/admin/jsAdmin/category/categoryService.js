angular.module('app')
    .service('CategoryService', ['$http', function ($http) {
        var baseUrl = 'http://localhost:8080/api/categories';

        var loginToken = localStorage.getItem('jwtToken');

        // Thêm header với token vào tất cả các yêu cầu HTTP
        var config = {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + loginToken.replace(/"/g, '').trim()
            }
        };

        this.getCategoriesPage = function (page, size) {
            page = page || 0;
            size = size || 5;

            return $http.get(baseUrl, {
                params: {page: page, size: size},
                headers: config.headers
            }).then(function (response) {
                return response.data;
            }).catch(function (error) {
                console.error('Error fetching categories', error);
                throw error;
            });
        };

        this.getCategoryById = function (id) {
            return $http.get(baseUrl + '/' + id, config)
                .then(function (response) {
                    return response.data;
                })
                .catch(function (error) {
                    console.error('Error fetching category', error);
                    throw error;
                });
        };

        this.createCategory = function (category) {
            return $http.post(baseUrl, category, config)
                .then(function (response) {
                    return response.data;
                })
                .catch(function (error) {
                    console.error('Error creating category', error);
                    throw error;
                });
        };

        this.updateCategory = function (id, category) {
            return $http.put(baseUrl + '/' + id, category, config)
                .then(function (response) {
                    return response.data;
                })
                .catch(function (error) {
                    console.error('Error updating category', error);
                    throw error;
                });
        };

        this.deleteCategory = function (id) {
            return $http.delete(baseUrl + '/' + id, config)
                .then(function (response) {
                    return response.data;
                })
                .catch(function (error) {
                    console.error('Error deleting category', error);
                    throw error;
                });
        };

        this.checkName = function (name, excludeId) {
            return $http.get(baseUrl + '/check-name', {
                params: {name: name, excludeId: excludeId},
                headers: config.headers
            }).then(response => response.data);
        };

        this.getCategoriesByItemId = function (itemId) {
            return $http.get(baseUrl + '/by-item/' + itemId, config)
                .then(function (response) {
                    return response.data;
                })
                .catch(function (error) {
                    console.error('Error fetching categories', error);
                    throw error;
                });
        };

    }]);
