/**
 * appForecast
 */
(function () {

  //vars
  var $metroList = $('#metroList');
  var $dragObj = $metroList.children('.metroCircle');
  var $dropTarget = $('.dropTarget');
  var droppedCssProp = {
    left: '0',
    top: '0'
  };
  var circleSize = 36;

  //subRoutine
  // function initMetroList() {
  //   $metroList.html('');
  //   $dropTarget.html();

  //   $metroList.html(metroItems);
  // };

  function appInit (){
    //drag
    $dragObj.draggable({
      start: function(e, ui) {
        console.log('hoge');
      },
      stop: function (e, ui) {
        var targetLineName = $(e.target).data('line_name');
      }
    });

    //drop
    $dropTarget.droppable({
      hoverClass: 'is-hover',
      tolerance: 'intersect',
      drop: function (e, ui) {
        var $this = $(this);
        var mousePointX = e.clientX;
        var mousePointY = e.clientY;

        var $targetMetroCircle = $(document.elementFromPoint(mousePointX, mousePointY));
        $targetMetroCircle.css(droppedCssProp);
        $this.append($targetMetroCircle.clone());

        $targetMetroCircle.remove();

      }
    });
  };

  //init
  //initMetroList();
  appInit();


})();
