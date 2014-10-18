/**
 * metroStatus
 */
(function () {

  // change deletemeter from <%= %> to {{ }}
  _.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
  };

  //vars
  var delayInfoArr = [];
  var maxDelayPoint = 0;
  var ajaxUrl = 'https://private-734ec-tokyometoto.apiary-mock.com/api/v1/delay';
  var template = _.template($('#metroStatusTemplate').text());
  var $metroStatusField = $('#metroStatusField');
  var $imgVehicle ={};

  // subRoutine
  function sortDelayInfo (arr) {
    arr.sort(function(a, b) {
      return (a.sort < b.sort) ? -1 : 1;
    });

    return arr;
  };

  function getMaxDelayPoint (arr) {
    var _delayArr = [];

    for(key in arr){
      _delayArr.push(Number(arr[key].delay));
    }

    maxDelayPoint = Math.max.apply(null, _delayArr);
  };

  $.ajax({
    type: 'GET',
    url: ajaxUrl,
    dataType: 'json',
    success: function (res) {
      delayInfoArr = sortDelayInfo(res);
      getMaxDelayPoint(delayInfoArr);

      _.each(delayInfoArr, function(delayInfo) {

        var dom = template({
          initial_text: delayInfo.line.substr(0,1),
          line: delayInfo.line.toLowerCase(),
          delay: Number(delayInfo.delay),
          image_path: delayInfo.image_path
        });
        $metroStatusField.append(dom);
      });

      setTimeout(function () {
        $imgVehicle = $metroStatusField.find('.imgVehicle');

        for(var i = 0, I = $imgVehicle.length; i < I; i ++){
          $imgVehicle.eq(i).css('padding-left', $imgVehicle.eq(i).data('delay_point') + 'px');
        }
      }, 1000);
    },
    error: function () {
      alert('サーバーエラーです');
    }
  });
})();
