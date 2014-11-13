
var itineraryServices = angular.module('itineraryServices', ['ngResource']);

itineraryServices.factory('Itinerary', ['$resource',
  function($resource) {
    return $resource('gp' + '.json', {}, {
      query: {
        method: 'GET'
      }
    });
  }
]);