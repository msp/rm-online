'use strict'

describe 'Controller: PagesContactCtrl', ->

  # load the controller's module
  beforeEach module 'rmOnlineApp'

  PagesContactCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    PagesContactCtrl = $controller 'PagesContactCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
