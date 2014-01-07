var planServices = angular.module('planServices', ['ngResource']);

planServices.factory('Plan', ['$resource',
  function($resource) {
    return $resource('plan.json', {}, {
      query: {
        method: 'GET',
        isArray: false
      }
    });
  }
]);