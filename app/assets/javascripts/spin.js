
// $(document).ready(function(){
//   $('.btn--block').click(function(){
//     $(this).spin();
//   })
// });
//スピナーオブジェクト
var spinner = null;
//表示先
var target = null;
//状態
var state = false;
$(function() {
	init();
	$('.btn--block').click(function() {
		if(!state) {
			spinner.spin(target);
			state = true;
		} else {
			spinner.stop();
			state = false;
		}

	});
});
function init() {
	var opts = {
	  lines: 13, // The number of lines to draw
	  length: 33, // The length of each line
	  width: 11, // The line thickness
	  radius: 16, // The radius of the inner circle
	  corners: 1, // Corner roundness (0..1)
	  rotate: 74, // The rotation offset
	  direction: 1, // 1: clockwise, -1: counterclockwise
	  color: '#000', // #rgb or #rrggbb or array of colors
	  speed: 1.5, // Rounds per second
	  trail: 71, // Afterglow percentage
	  shadow: true, // Whether to render a shadow
	  hwaccel: true, // Whether to use hardware acceleration
	  className: 'spinner', // The CSS class to assign to the spinner
	  zIndex: 2e9, // The z-index (defaults to 2000000000)
	  top: '50%', // Top position relative to parent
	  left: '30%' // Left position relative to parent
	};
	target = document.getElementById('spin-area');
	spinner = new Spinner(opts);
}
//
// var opts = {
//   lines: 13, //線の数
//   length: 33, //線の長さ
//   width: 11, //線の幅
//   radius: 16, //スピナーの内側の広さ
//   corners: 1, //角の丸み
//   rotate: 74, //向き(あんまり意味が無い・・)
//   direction: 1, //1：時計回り -1：反時計回り
//   color: '#000', // 色
//   speed: 1.5, // 一秒間に回転する回数
//   trail: 71, //残像の長さ
//   shadow: true, // 影
//   hwaccel: true, // ？
//   className: 'spinner', // クラス名
//   zIndex: 2e9, // Z-index
//   top: '50%', // relative TOP
//   left: '30%', // relative LEFT
//   opacity: .25, //透明度
//   fps: 20 //fps
// };
// //描画先の親要素
// var spin_target = document.getElementById('spin-area');
// //スピナーオブジェクト
// var spinner = new Spinner(opts);
// //スピナー描画
// spinner.spin(spin_target);
// //もう一度spinを呼ぶとスピナー停止
// spinner.spin();
// //これでも止まります
// //spinner.stop();