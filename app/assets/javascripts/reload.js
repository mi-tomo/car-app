function submit_confirm() {
  if (window.confirm('送信してよろしいですか？')) {
    var opts = {
      lines: 12,        // The number of lines to draw
      length: 7,        // The length of each line
      width: 9,         // The line thickness
      radius: 30,       // The radius of the inner circle
      color: '#000',    // #rgb or #rrggbb
      speed: 1,         // Rounds per second
      trail: 60,        // Afterglow percentage
      shadow: false     // Whether to render a shadow
    };
    // 描画先の親要素
    var spin_target = document.getElementById('container');
    // スピナーオブジェクト
    var spinner = new Spinner(opts);
    // スピナー描画
    spinner.spin(spin_target); 
    return true;
  }
 else {
       return false;
   }
}
