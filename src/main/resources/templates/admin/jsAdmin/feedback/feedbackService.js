angular.module('app')
    .service('FeedbackService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/feedbacks';

        var loginToken = localStorage.getItem('jwtToken');

        // Thêm header với token vào tất cả các yêu cầu HTTP
        var config = {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + loginToken.replace(/"/g, '').trim()
            }
        };

        this.getFeedbacksPage = function(page, size) {
            page = page || 0;
            size = size || 8;
            return $http.get(baseUrl, {
                params: { page: page, size: size },
                headers: config.headers
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching feedbacks', error);
                throw error;
            });
        };

        this.updateFeedback = function(id, feedback) {
            return $http.put(baseUrl + '/' + id, feedback, config)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating feedback', error);
                    throw error;
                });
        };
    }]);
