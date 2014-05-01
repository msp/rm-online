'use strict'

describe 'Controller: PagesFaqCtrl', ->

  # load the controller's module
  beforeEach module 'rmOnlineApp'

  PagesFaqCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    PagesFaqCtrl = $controller 'PagesFaqCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
