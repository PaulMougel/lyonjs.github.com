(function() {
  var assert, francejs;

  assert = require('assert');

  francejs = require('../');

  describe('Array', function() {
    describe('indexOf', function() {
      return it('should return -1 when the value is not present', function() {
        assert.equal(-1, [1, 2, 3].indexOf(5));
        return assert.equal(-1, [1, 2, 3].indexOf(0));
      });
    });
    return describe('poc', function() {
      return it('should export value 3', function() {
        return assert.equal(3, francejs);
      });
    });
  });

}).call(this);
