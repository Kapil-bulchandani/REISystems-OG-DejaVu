var dejaVuServices = angular.module('dejaVuServices', ['ngResource']);

dejaVuServices.factory('DejaVuForm', ['$resource',
    function($resource){
        var $baseUrl = 'ec2-52-2-165-143.compute-1.amazonaws.com:28017/dejavu_mongo/';
        return $resource($baseUrl, {}, {
            query: {method:'GET', params: {'filter_': '@formId'}, isArray:true},
            get: {method:'GET', params: {'filter_': '@formId'}, isArray:false}
        });
    }
]);
