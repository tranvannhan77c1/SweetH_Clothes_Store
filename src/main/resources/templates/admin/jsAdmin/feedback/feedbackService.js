angular.module('app')
    .service('FeedbackService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/feedbacks';

        this.getAllFeedbacksPage = function(page, size) {
            page = page || 0;
            size = size || 8;
            return $http.get(baseUrl, {
                params: { page: page, size: size }
            }).then(function(response) {
                return response.data;
            }).catch(function(error) {
                console.error('Error fetching feedbacks', error);
                throw error;
            });
        };

        this.updateFeedback = function(id, feedback) {
            return $http.put(baseUrl + '/' + id, feedback)
                .then(function(response) {
                    return response.data;
                })
                .catch(function(error) {
                    console.error('Error updating feedback', error);
                    throw error;
                });
        };
    }]);
